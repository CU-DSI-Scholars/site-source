---
title: 'Efficiently representing genetic diversity from thousands of microbiome samples'
date: '2019-09-30'
slug: project-efficiently-representing-genetic-diversity-from-thousands-of-microbiome-samples
categories:
  - Project Fall 2019
tags:
  - Fall 2019
  - Python
  - C++
  - Microbiome
  - Sparsity
  - Algorithms
  - Data structures
thumbnailImagePosition: left
thumbnailImage: //res.cloudinary.com/vdoriecu/image/upload/c_thumb,w_200,g_face/v1569958426/microbiome_kw1dh4.png
---
The microbiome comprises a heterogeneous mix of bacterial strains, many with strong association to human diseases. Recent work has shown that even the same bacteria could have differences in their genomes across multiple individuals. Such differences, termed structural variations, are strongly associated with host disease risk factors [1]. However, methods for their systematic extraction and profiling are currently lacking. This project aims to make cross-sample analysis of structural variants from hundreds of individual microbiomes feasible by efficient representation of metagenomic data. The colored De-Bruijn graph (cDBG) data structure is a natural choice for this representation [2]. However, current cDBG implementations are either fast at the cost of a large space, or highly space efficient but either slow or lacking valuable practical features.

<!--more-->

We will develop a space efficient cDBG representation that is fast and integrates well with other pipelines that offer valuable features, combine advantageous features from efficient cDBG representation into a novel cDBG representation that integrates well with other pipelines. A successful project will enable large-scale cross-sample analysis of structural variants, advancing our understanding of the relation between human health and the microbiome.
[1] Zeevi, D. et al. Nature 2019.
[2] Iqbal, Z., et al. Nature Genetics 2012.

{{< alert success >}}
One selected candidate will receive a stipend via the DSI Scholars program. Amount is subject to available funding.
{{< /alert >}}

## Faculty Advisor
+ Professor: [Tal Korem](https://www.koremlab.science/)
+ Department/School: Department of Systems Biology
+ Location: PH18-200
+ The Korem lab studies what human-associated microbial communities (the "microbiome") tell us about their host and how they affect its health. We aim to develop personalized microbiome-based and -guided therapeutics and diagnostics.

## Project Timeline
+ Earliest starting date: 10/15/2019
+ End date: 05/31/2020
+ Number of hours per week of research expected during Fall 2019: ~10

## Candidate requirements
+ Skill sets: Students should have familiarity with Unix environment, python, C++, and an interest in efficient algorithm design and implementation.
+ Student eligibility: ~~freshman~~, sophomore, junior, senior, master's
+ International students on F1 or J1 visa: **eligible**
