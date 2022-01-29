---
title: 'D-Hacking'
date: '2022-01-28'
slug: project-d-hacking
categories:
  - Open  2022
tags:
  -  2022
thumbnailImagePosition: left
thumbnailImage: https://github.com/CU-DSI-Scholars/site-source/blob/main/static/img/ML.jpg?raw=true
---
It has long been recognized that there could be a tradeoff between optimizing the accuracy of machine learning predictions and satisfying definitions of fairness for protected or vulnerable groups. This tradeoff has led to an increased interest in finding models that both perform well while also exhibiting fairness properties. 

<!--more-->

In this project we caution against the risks of over-optimizing for fairness definitions within a sample so that the selected model ends up performing worse with respect to fairness out-of-sample. Much like how the classic bias-variance tradeoff leads to overfitting of high variance models, so too the overfitting of sensitive fairness definitions to a sample could mean the fairness criteria does not generalize. In some cases, fairness constraints that perform worse within sample might lead to higher levels of unfairness out of sample. 
We call this effect d-hacking because the search over many models for a model that is least discriminatory can lead to an effect analogous to the concern of p-hacking in social science research. P-hacking refers to situations in which a researcher runs statistical analyses until non-significant results become significant. This could mean that researchers ultimately document statistically significant results when in fact there is no real underlying effect. Similarly, discrimination-hacking (d-hacking) involves searching over models until one exhibits the desirable properties while the true object of interest is the fairness performance out-of-sample. 
To document and demonstrate this biased estimate of discrimination we intend to run simulations of training datasets in which we search of a larger family of models and model configuration to identify models that exhibit overall good performance but differ in their level of fairness. We then consider how these models perform along the fairness dimension in a hold-out set or another similar dataset. We hope to demonstrate that the model that gives the best in sample fairness measures can do worse out-of-sample suggesting that d-hacking increases discrimination. 


{{< alert success >}}
This project is eligible for a matching fund stipend from the Data Science Institute. This is not a guarantee of payment, and the total amount is subject to available funding.
{{< /alert >}}

## Faculty Advisor
+ Professor: [Talia Gillis](https://www.law.columbia.edu/faculty/talia-gillis)
+ Center/Lab: Law School
+ Location: Jerome Green Hall
+ Talia Gillis studies the law and economics of consumer markets and is interested in household financial behavior and how consumer welfare is shaped by technological and legal changes. Some of her recent work considers how artificial intelligence, and consumer fintech more broadly, is affecting consumers and raises distributional concerns.

## Project Timeline
+ Earliest starting date: 3/7/2022
+ End date: 7/31/2022
+ Number of hours per week of research expected during Spring/Summer 2022: ~10
+ Number of hours per week of research expected during Summer 2022: ~15

## Candidate requirements
+ Skill sets: Fluency in R/Python and experiment with simulations
+ Student eligibility: ~~freshman~~, ~~sophomore~~, ~~junior~~, ~~senior~~, ~~master's~~
+ International students on F1 or J1 visa: **NOT** eligible
+ Academic Credit Possible: Yes

