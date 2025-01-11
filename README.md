# 全自動スライドシステム 

[**slide.peruki.dev**](https://slide.peruki.dev)

by Teruki TADA

## 概要

以下の機能を提供します。
- スライドのビルド
    - HTML・PDFを生成し公開
- [一覧ページ]((https://slide.peruki.dev))の公開
    - 日付による整理
    - サムネイルの生成

また、以下の機能を提供します。

- 画像の圧縮 `make resize-image`
- スライドのリンクへのQRコードの生成 `make create-qr`

## 使い方

スライドは[Marp](https://marp.app/)で作成します。

1. `slides/[年]/[カテゴリ]/[輪読資料名]/slide.md`にスライドの内容を記述します。
ファイルの最初には、以下のように資料の情報を記述します。
(スライド一覧は、この情報を自動で取得し作成しています)
```markdown
---
marp: true
theme: peru24doc2
title: 学習物理学入門 A4
description: A4.1-A4.2の資料です。
math: mathjax
author: Teruki TADA
session: FUNAI輪読会
date: 2025-1-13
tags: FUNAI
thumbnail: img/okayama.webp
paginate: true
header: 学習物理学入門 A4 古典力学と機械学習:NNと微分方程式
---

(一枚目)

---

(二枚目)

---

...
```

2. `slides/[年]/[カテゴリ]/[輪読資料名]/img-original`に画像を保存します。
`make resize-image`で画像を圧縮することができ、`.../img`に保存されます。

3. git pushすると、GitHub Actionsにより、スライドが自動でビルド・公開されます。
