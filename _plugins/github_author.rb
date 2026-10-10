require "json"
require "net/http"
require "uri"

class GitHubAuthorGenerator < Jekyll::Generator
  priority :high

  def generate(site)
    username = site.config["github_username"].to_s.strip
    return if username.empty?

    unless username.match?(/\A[a-zA-Z0-9-]{1,39}\z/)
      Jekyll.logger.warn "GitHub author:", "invalid github_username; using fallback"
      return
    end

    uri = URI("https://api.github.com/users/#{username}")
    request = Net::HTTP::Get.new(uri)
    request["User-Agent"] = "jekyll-github-author"
    request["Accept"] = "application/vnd.github+json"
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true,
                               open_timeout: 5, read_timeout: 5) do |http|
      http.request(request)
    end
    unless response.is_a?(Net::HTTPSuccess)
      Jekyll.logger.warn "GitHub author:", "API returned #{response.code}; using fallback"
      return
    end

    profile = JSON.parse(response.body)
    unless profile["login"].to_s.casecmp?(username)
      Jekyll.logger.warn "GitHub author:", "profile mismatch; using fallback"
      return
    end

    profile_url = "https://github.com/#{profile.fetch('login')}"
    display_name = profile["name"].to_s.strip
    display_name = profile.fetch("login") if display_name.empty?
    links = [{ "label" => "GitHub", "icon" => "fab fa-fw fa-github", "url" => profile_url }]
    blog = profile["blog"].to_s.strip
    unless blog.empty?
      blog = "https://#{blog}" unless blog.match?(/\Ahttps?:\/\//i)
      blog_uri = URI.parse(blog)
      if %w[http https].include?(blog_uri.scheme) && blog_uri.host
        links << { "label" => "웹사이트", "icon" => "fas fa-fw fa-link", "url" => blog }
      end
    end

    author = {
      "name" => display_name,
      "avatar" => profile["avatar_url"].to_s,
      "home" => profile_url,
      "links" => links
    }
    bio = profile["bio"].to_s.strip
    author["bio"] = bio unless bio.empty?
    location = profile["location"].to_s.strip
    author["location"] = location unless location.empty?
    site.config["author"] = author
    site.config["social"] = { "name" => display_name, "links" => [profile_url] }
    Jekyll.logger.info "GitHub author:", "loaded #{profile.fetch('login')}"
  rescue StandardError => e
    Jekyll.logger.warn "GitHub author:", "#{e.class}: #{e.message}; using fallback"
  end
end
