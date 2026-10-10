---
title: "[샘플] 작은 기능을 기록하는 개발 노트"
date: 2026-10-08 09:00:00 +0900
categories: ["개발 공부"]
tags: ["샘플", "Markdown"]
excerpt: "코드와 이미지 표시를 확인하기 위한 예시 글입니다."
---

> 이 글의 코드와 그림은 게시글 기능 확인을 위한 예시입니다.

## 간단한 코드

```python
steps = ["관찰", "기록", "다음 행동"]
for step in steps:
    print(step)
```

## 이미지

![관찰에서 기록과 다음 행동으로 이어지는 샘플 그림]({{ '/assets/images/sample-diagram.svg' | relative_url }})

이미지는 `assets/images/`에 넣고 위처럼 `relative_url` 필터를 사용하면 프로젝트 하위 경로에서도 표시됩니다.
