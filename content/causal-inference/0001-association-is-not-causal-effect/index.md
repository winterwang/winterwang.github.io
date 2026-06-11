---
title: "0001 - Association 還不是 Causal Effect"
subtitle: "第一節因果推論微課：用 kidney stone 例子分清 association measure 與 causal effect。"
summary: "用 Ding 第一章的 kidney stone 例子，練習 risk difference、分層比較，以及為什麼 association 還需要 estimand 和 comparability 才能走向 causal interpretation。"
date: 2026-06-11
lastmod: 2026-06-11
draft: false
tags:
  - Causal Inference
  - Study Design
  - Association
  - Potential Outcomes
categories:
  - Causal Inference Micro-Lessons
---

這一節只做一件事：用一個小例子看清楚，資料裡的 association 可以提示問題，但它還不是 causal effect。

成功標準：能算出 risk difference、看出邊際與分層方向不一致，並用一句話說明為什麼這還不是 causal conclusion。

## 來源定位

主要來源：Peng Ding, *A First Course in Causal Inference*，chapter 1 kidney stone example，約 PDF page 33–35。

輔助來源：Miguel Hernan and James Robins, *Causal Inference: What If*，chapter 1 對 association 與 causation 的區分。官方教材頁在 [miguelhernan.org/whatifbook](https://miguelhernan.org/whatifbook)。

NotebookLM：[`Causal inference`](https://notebooklm.google.com/notebook/40336692-89bc-44d3-a3ac-d4e19bf15a8e) 只作為來源定位，不作為最後權威。

## 最小公式

先只看二元 treatment `Z` 與二元 outcome `Y`。risk difference 是：

```text
RD = Pr(Y = 1 | Z = 1) - Pr(Y = 1 | Z = 0)
```

這個量本身是 association measure。它比較的是實際接受不同 treatment 的兩群人，而不是同一個目標族群在兩個 treatment 值下的反事實結果。

## Kidney Stone 資料

Ding 第一章的例子把 treatment 設為 `Z = 1` open surgical procedure，`Z = 0` small puncture procedure；outcome `Y = 1` 表示成功。

| 資料層次 | Z = 1 成功 / 總數 | Z = 0 成功 / 總數 | 先自己算 RD |
|---|---:|---:|---:|
| 全部病人 | 273 / 350 | 289 / 350 |  |
| 小結石 | 81 / 87 | 234 / 270 |  |
| 大結石 | 192 / 263 | 55 / 80 |  |

## 你的 7 分鐘任務

1. 算出三個 RD：全部、小結石、大結石。
2. 標記每個 RD 是正還是負。
3. 寫一句話：如果只看全部病人，我們會怎麼說？如果看分層後，我們又會怎麼說？

先不要急著說哪個 treatment 比較好。這一節只問 association 的方向，不直接跳到 causal conclusion。

<details>
<summary>計算檢查</summary>

全部病人：

```text
273 / 350 - 289 / 350 = -0.046
```

小結石：

```text
81 / 87 - 234 / 270 = 0.064
```

大結石：

```text
192 / 263 - 55 / 80 = 0.043
```

不難注意到，邊際 RD 是負的，但兩個分層 RD 都是正的。這就是本節要抓住的現象。

</details>

## 第一個解讀

邊際 association 說：在全部病人中，`Z = 1` 的成功率較低。分層 association 說：在小結石與大結石兩組內，`Z = 1` 的成功率都較高。

這種方向不一致不是數學錯誤，而是提醒我們：接受 treatment 的人可能不是同一類人。於是，association 要成為 causal effect 之前，至少需要回答兩個問題：

1. 我們的目標估計量 estimand 是哪一個族群、哪兩個 treatment 值下的結果差？
2. 我們憑什麼相信比較的兩群人在 relevant covariates 上足夠可比？

## 通往下一節

Ding chapter 2 的 potential outcomes 會把問題改寫成：對同一個 unit，我們想比較 `Y(1)` 與 `Y(0)`。但同一個 unit 實際上只能觀察到其中一個，這就是為什麼 study design 與 assumptions 會變得重要。

下一節可以從 potential outcomes 的最小語言開始：unit、treatment、outcome、`Y(1)`、`Y(0)`、observed outcome。

## 下次開始前的回憶問題

不要看答案，先口頭回答：為什麼 kidney stone 例子裡，「分層後方向一致」仍然不自動等於 causal effect？

如果卡住，回到兩個詞：estimand 與 comparability。
