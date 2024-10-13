---
marp: true
title: スライドシステム再構築
description: スライドの作成用システムを再構築しました
theme: peru24
paginate: true
header: Mariners' Conference 未来祭LT 2024
session: 未来祭LT 2024
date: 2024-10-13
tags: LT, Marp, Svelte
thumbnail: img/thumbnail.webp
---

# スライドシステム再構築

多田 瑛貴 ただ てるき

![bg right:25% 70%](img/qr.png)

---

# 自己紹介

多田 瑛貴 ただ てるき
FUN 学部3年 複雑系コース

言語: Rust / TypeScript (Svelte)
主な関心: 空間情報処理 / Webグラフィックス

![bg right:30% 70%](img/peruki.webp)


---

![bg](img/rentour.webp)

---

弱点

---

# ない


![bg right:50%](img/tada.webp)

---

テーマ: 今ハマっていること

---

# スライド作り

- 9/29 函館高専合同LT
- 10/6 YAPC函館市電LT

---

(ハマる=苦しむ)

---

# スライドを"簡単に"共有したい

---

# 簡単に？

- テキスト書くだけでデザインごと作れる
- git管理できる
- 作った直後にWeb上にアップロード
    - デバイス関係なくプレゼンできる
    - QRコードも自動で作成して共有
- 過去のスライド一覧もWebで自動作成

---

# 成果物

**https://slides2.peruki.dev**


![bg right:30% 70%](img/qr.png)



---

# テキストでスライド作成

**Marp**: Markdownでスライドを作成するツール

`html`や`pdf`等の複数プラットフォームにビルド可能

![bg right:30% 90%](img/marp.webp)


---

![bg](img/system.png)

---


# 使う手順
- `vscode`でMarkdownを編集
- 魂の`git push origin main`
- **待つ！**
  - **GitHub Actions**が各種ビルドをしてくれる
  - `main-deploy`ブランチにスライドがアップロードされる
  - **Cloudflare Pages**で公開される

---

# GitHub Actionsについて

**Github Actions**
Gitのpushやpull requestなどのイベントに対して、自動で処理を行う機能

`git push`と同時にタスクを起動してくれる

---

# GitHub Actionsがやること (色々！)

- `slides`ディレクトリ内のMarkdownを探す
    - `marp-cli`でHTMLにビルド
    - 画像をリサイズした`webp`に変換
    - QRコードを作成し画像に追加
    - スライドからタイトルや詳細を取得
        - JSONのスライドリストを作成
- スライド一覧のWebページをビルド
    - ビルドしたスライドや画像を
    Webページのサブディレクトリに再配置
    - JSONのスライドリストに基づいて一覧を作成

---

# 考慮すべきことたくさん

- 画像素材を直接pushはしたくない
 → リサイズした画像のみ差分を考慮したい
- 全スライドのビルドは時間がかかる
 → Markdownのハッシュを作成し、JSONのスライドリストに格納
 更新されているスライドのみビルドする

**Shell Scriptが地獄になる**

---

# 地獄のShell Script

find slides -name '*.md' -print  | while read -r file; do
    ...(marp-cliを実行しHTMLを生成)
    ...(画像をwebpに変換 with ImageMagick)
    ...(スライドのリストをjson形式で作成)
done

Actionsで実際に動かすのは合計150行くらい

---

# 見ろ！

---

# デモ

---

# まとめ

- Marpはいいぞ
  - テキストで簡単にスライドを作成
  - **(テキストだからこそ自動化できる！)**
- Shell Scriptはいいぞ
  - CLIを組み合わせて作業自動化
- GitHub Actionsはいいぞ
- Cloudflare Pagesはいいぞ
- Svelteはいいぞ
