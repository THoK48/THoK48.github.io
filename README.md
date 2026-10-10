# 기술 기록 블로그

한국어 기술 블로그의 시작점입니다. Jekyll 4.4, Minimal Mistakes 4.28.1, Markdown 게시글과 GitHub Actions 기반 Pages 배포를 사용합니다. 공식 Minimal Mistakes GitHub Pages 스타터의 페이지 구조를 바탕으로 작성했습니다.

## 로컬 실행

Ruby 3.2와 Bundler를 설치합니다. Windows에서는 [RubyInstaller + DevKit](https://rubyinstaller.org/)을 권장합니다. Jekyll의 Windows 환경은 공식 지원 대상이 아니므로 WSL도 사용할 수 있습니다.

```sh
bundle install
bundle exec jekyll serve
```

브라우저에서 `http://127.0.0.1:4000/`을 엽니다. 배포용 주소를 확인하려면 `_config.yml`의 `url`, `baseurl`을 설정하고 `JEKYLL_ENV=production bundle exec jekyll build`를 실행합니다. Windows PowerShell에서는 `$env:JEKYLL_ENV='production'`을 먼저 설정합니다.

## 게시글 작성

`_posts/YYYY-MM-DD-slug.md` 파일을 만들고 다음 머리말을 사용합니다.

```yaml
---
title: "제목"
date: 2026-10-09 09:00:00 +0900
categories: ["개발 공부"]
tags: ["Jekyll", "기록"]
excerpt: "목록과 검색 결과에 사용할 요약"
---
```

본문은 Markdown으로 씁니다. 목차, 코드 하이라이팅, 관련 글과 이전/다음 글은 기본 설정으로 표시됩니다. 이미지는 `assets/images/`에 넣고 `![설명]({{ '/assets/images/example.png' | relative_url }})` 형식으로 넣습니다. 샘플 글 3개는 실제 게시 전에 삭제하거나 본인 글로 교체하세요.

## 카테고리와 태그

기본 카테고리는 `정보처리기사`, `개발 공부`, `프로젝트`, `트러블슈팅`, `TIL`입니다. 글의 `categories`와 `tags` 배열에 새 값을 넣으면 카테고리·태그 페이지에 자동으로 나타납니다. 탐색 메뉴는 `_data/navigation.yml`에서 수정합니다.

## 디자인

`_config.yml`의 `minimal_mistakes_skin`과 `assets/css/main.scss`의 변수·추가 규칙을 수정합니다. 테마 파일을 복사해 대규모로 재작성하지 않았습니다. 한글 폰트는 시스템 폰트 우선이므로 별도 웹폰트 요청이 없습니다.

## GitHub 작성자 정보

`_config.yml`의 `github_username`에 GitHub 사용자명을 적습니다. 빌드할 때 `_plugins/github_author.rb`가 공개 GitHub 프로필에서 표시 이름, 아바타, 소개, 위치, 프로필 링크와 공개 웹사이트 링크를 가져와 사이드바에 반영합니다. 프로필 변경 사항은 다음 빌드 때 적용됩니다. API에 연결할 수 없으면 `_config.yml`의 작성자 기본값으로 빌드합니다. 공개 프로필만 사용하며 별도 토큰은 필요하지 않습니다.
## 검색 및 SEO

Minimal Mistakes의 Lunr 검색을 사용하며, SEO 메타데이터는 `jekyll-seo-tag`, 사이트맵은 `jekyll-sitemap`, RSS는 `jekyll-feed`가 생성합니다. `robots.txt`도 포함됩니다. 검색 콘솔을 사용할 때 `_config.yml`에 `google_site_verification` 항목을 추가해 실제 인증 값을 입력하고 Google Search Console에서 소유권 인증을 마치세요. 사이트가 확정되면 `url`, `baseurl`, 제목, 설명을 검토하세요.

## GitHub Pages 배포

1. GitHub에서 새 저장소를 만들고 이 폴더를 연결합니다. 사용자 사이트를 원하면 저장소 이름을 **GitHub 사용자명**에 해당하는 `USERNAME.github.io`로 만듭니다. 다른 이름의 저장소도 프로젝트 사이트로 배포할 수 있습니다.
2. 본인 Git 계정 설정을 확인한 뒤 직접 커밋하고 `main` 브랜치에 푸시합니다.
3. 저장소 **Settings → Pages → Build and deployment → Source**를 **GitHub Actions**로 선택합니다.
4. Actions의 `Build and deploy Jekyll site` 실행 결과와 공개 주소를 확인합니다. 워크플로는 Pages가 알려 주는 주소를 빌드에 적용하므로 프로젝트 하위 경로도 처리합니다.

개인 도메인을 쓰려면 Pages 설정에 도메인을 등록하고 DNS를 설정한 후 HTTPS를 활성화하세요. 필요한 경우 저장소 루트에 `CNAME` 파일을 추가합니다. 도메인 연결 후 실제 `url`과 `baseurl`을 확인하세요.

## AdSense 준비

광고는 기본적으로 완전히 꺼져 있으며 광고 스크립트도 출력하지 않습니다. 승인 후 `_config.yml`의 `ads.publisher_id`에 `ca-pub-...`, 원하는 위치의 `*_slot`에 광고 단위 ID를 입력하고 `ads.enabled`와 해당 `*_enabled`를 `true`로 바꿉니다. 본문 광고는 원하는 글의 적절한 문단 사이에 `{% include ads/in-article.html %}`을 **한 번만** 넣습니다. 사이드바 광고는 데스크톱에서만 표시되며, 하단 광고는 별도로 켤 때만 표시됩니다. 모바일 독서 흐름을 확인하며 광고 개수를 조절하세요.

AdSense가 안내한 `ads.txt` 내용이 있으면 저장소 루트에 `ads.txt` 파일을 만들어 **승인된 계정의 실제 게시자 ID**로 게시합니다. 예시 형식은 `google.com, pub-실제ID, DIRECT, f08c47fec0942fa0`이며, 값은 AdSense 화면의 안내와 대조하세요. 사이트의 `/ads.txt`에서 접근되는지 확인합니다.

`_pages/privacy.md`는 공개 전 검토용 틀입니다. 실제 사용하는 광고·분석·댓글·문의 서비스에 맞춰 쿠키, 개인정보, 동의 및 문의 정보를 직접 검토해야 합니다. 광고 승인이나 수익은 보장되지 않습니다.

## 호스팅 선택

GitHub Pages는 정적 사이트를 공개할 수 있지만 [사용 제한](https://docs.github.com/en/pages/getting-started-with-github-pages/github-pages-limits)이 있습니다. GitHub는 주로 상거래 거래나 SaaS 제공을 목적으로 하는 사이트의 무료 호스팅 용도로 Pages를 허용하지 않으며, 저장소·사이트 크기와 대역폭 제한도 안내합니다. 이 블로그의 실제 운영 방식이 해당 제한이나 정책에 맞지 않게 바뀐다면 [Cloudflare Pages의 Jekyll 배포](https://developers.cloudflare.com/pages/framework-guides/deploy-a-jekyll-site/) 등을 검토하세요. 광고 운영 정책은 사용하는 서비스의 최신 약관과 실제 사이트 내용에 맞춰 확인하세요.

## 직접 변경할 설정

- `_config.yml`: 제목, 설명, `github_username`, 연결 실패 시 사용할 작성자 기본값, 도메인 주소와 하위 경로, Search Console 인증 값
- `_pages/about.md`, `_pages/privacy.md`: 실제 운영 정보와 개인정보 고지
- `_posts/`: 샘플 글 교체와 실제 글 작성
- 승인 후에만 `_config.yml`의 광고 ID·활성화 상태 및 필요시 `ads.txt`
- GitHub 저장소 생성, Pages 설정, 도메인 DNS 및 외부 서비스의 계정 인증
