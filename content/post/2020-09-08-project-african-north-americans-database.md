---
title: 'Data For Good: African North Americans Database'
author: Vincent Dorie
date: '2020-09-08'
slug: project-dfg-african-north-americans-database
categories:
  - Open Projects Fall 2020
  - Data For Good
tags:
  - Data For Good
  - Record linkage
  - Deduplication
  - R
  - Python
  - Shiny
  - Tableau
  - Power BI
  - Fall 2020
thumbnailImagePosition: left
thumbnailImage: //res.cloudinary.com/vdoriecu/image/upload/c_thumb,w_200,g_face/v1569955380/african_north_americans_cybrfk
---

This project is the first comprehensive examination of African North Americans who crossed one of the U.S.-Canada borders, going either direction, after the Underground Railroad, in the generation alive roughly 1865-1930. It analyzes census and other records to match individuals and families across the decades, despite changes or ambiguities in their names, ages, "color," birthplace, or other details.

<!--more-->

The main difficulty in making these matches is that the census data for people with a confirmed identity does not stay uniform decade after decade. Someone might be recorded not with their given name but instead a nickname (Elizabeth to Betsy); women can marry or get remarried and change their names; racial measures by a census taker may change (black to mulatto, or mulatto to white); someone might say they are from Canada, even when they were born in Kentucky, depending on how the question was asked; people who were estimating their ages might be 35 in 1870 and 40 in 1880 and 50 in 1890, for example. Another difficulty is that data from different sources may have different fields, which require extensive processing and normalization.

To date, approximately 2,600 matches have been generated either manually or by record linkage algorithms in a database of 50,000 records. Manually, matches were made by looking first at the calculated birth year, then at the name given, location, place of birth, and sometimes at household members. Matches were also identified with record linkage methods, both supervised and unsupervised, and named-entity recognition. Finding an algorithmic way to predict and identify these matches will allow these records to be paired with other sources, such as government pension data, and will factor into research on migration patterns, specific families, and nodes - whether personal or geographic — that tie these African North American groups together.

Project objectives include:

+ Finding more ways to predict more matches with probabilistic record linkage, clustering, conditional random fields, active learning etc. A related goal is to deduplicate the data – i.e. finding records that belong to the same individuals and removing duplicate records.
+ Deriving a confidence score of matches based on name, birth year, family structure, location, occupations etc.
+ Expanding the current dataset by (1) scraping census data for the rest of the households of those in the database, (2) using and processing outputs of OCR. This will expand the reach of the database and allow for additional matches/
+ Visualizing the movements of identified individuals with Tableau, Power BI or R Shiny.

{{< alert success >}}
This is a volunteer opportunity for students to use their skills for the social good.
{{< /alert >}}

## Project Owner
+ Professor [Adam Arenson](https://manhattan.edu/campus-directory/adam.arenson), Manhattan College
+ Adam Arenson teaches the history and memory of North America and the global nineteenth century. His work has concentrated on the cultural and political history of slavery, Civil War, and Reconstruction, as well as the development of cities--from California to the Yukon Territory, from the province of Ontario to St. Louis to El Paso. 

## Project timeline
+ Earliest starting date: 10/01/2020
+ End date: Ongoing
+ Number of hours per week of work research expected during Fall 2020: ~6-8
+ Project is ongoing and will be reviewed for future directions at the end of the semester

## Candidate requirements
+ Skill sets: Familiarity with concepts of record linkage and deduplication in both an unsupervised and supervised context would be ideal, however sufficient background knowledge in probability and maximum likelihood/machine learning to learn these topics is sufficient. Ability to program in a language like R or Python that has record linkage software available is required. Ability to visualize data using Tableau/R Shiny and Power BI is a plus.
+ Student eligibility: freshman, sophomore, junior, senior, master's
+ For coordinator position, international students on F1 or J1 visa: **eligible**

