---
marp: true
theme: peru24lab
title: Physics Informed Deep Learning (Part I)
description: Physics Informed Deep Learning (Part I) Data-driven Solutions of Nonlinear Partial Differential Equations
math: mathjax
author: Teruki TADA
session: 研究室活動
date: 2025-1-14
tags: 研究室活動
thumbnail: img/tokyo.webp
paginate: true
---

# "Physics Informed Deep Learning (Part I): Data-driven Solutions of Nonlinear Partial Differential Equations"

発表者: 多田 瑛貴 (公立はこだて未来大学 島内研究室)

---

## 本研究の概要

"physics-informed neural networks" (PINNs) の提案
- 非線形偏微分方程式を解くデータ駆動型のアプローチ
- 境界条件を教師データとしつつ、偏微分方程式を与えることで
  物理法則を満たすようニューラルネットワークを学習
- 既知の物理法則に対して、少量のデータから有用な近似解を提供
- パラメータ不定の微分方程式に対しても適用可能 (Part IIで詳説)

---

# 背景

非線形写像を深層学習を使って学習するとき
現実の多くの場面では、教師データを十分な量取得できない
*データが少ない場合、結果のロバスト性や、学習を通したモデルの収束を保証できなくなる*

-> 学習に既知の支配方程式を利用したい

---

## 従来手法

- ルンゲ・クッタ法
- 有限要素法 
- Gaussian process regression (GPR)
(一旦省略)

---

# 提案手法


---

## 学習対象

支配方程式を次のように表現 ($u(t, x)$: 未知関数, $\lambda$: パラメータ)

$$ u_t + \mathcal{N}[u; \lambda] = 0 $$

現実の物理法則の多くは、この形式で表現可能
*例: Burgers方程式 $u_t+\lambda_1uu_x-\lambda_2u_{xx}=0$ より $\mathcal{N}[u; \lambda] = \lambda_1uu_x-\lambda_2u_{xx}$*

この式を満たす写像 $u(t,x)$ を学習する

---

## 学習の方針

---

# 実験

---

# まとめ

---

# Part IIの内容

---

# 感想

---

# 個人用: TODO

「物理法則」「支配方程式」「微分方程式」などバラバラの言葉が混在しているので、絞る