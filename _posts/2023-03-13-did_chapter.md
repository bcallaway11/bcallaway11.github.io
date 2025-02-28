---
title: "DID Chapter in Handbook of Labor, Human Resources and Population Economics"
output:
  md_document:
    variant: "gfm+tex_math_dollars"
    preserve_yaml: TRUE
author: "brant"
date: '2023-03-13'
layout: single
permalink: /posts/did-chapter
categories:
  - Econometrics
  - Policy Evaluation
  - Panel Data
  - Event Study
comments: true
---

My chapter on difference-in-differences just published in the *Handbook
of Labor, Human Resources and Population Economics*.

The published version is
[here](https://link.springer.com/referencework/10.1007/978-3-319-57365-6),
and a draft of the chapter is available on [my
website](https://bcallaway11.github.io/files/Callaway-Chapter-2022/main.pdf)

The chapter follows pretty closely what I teach about DID in my
Ph.D. econometrics course at UGA. It’s probably less of a
“practitioner’s guide” and more of an introduction to the literature for
an econometrics student. And, in particular, the chapter includes:

1)  Proofs of main results in the literature (e.g., Goodman-Bacon
    (2021), Callaway and Sant’Anna (2021), Sun and Abraham (2021)) in a
    unified notation.

2)  A careful comparison of alternative estimation strategies that have
    recently been proposed in order circumvent the issues with two-way
    fixed effects regressions. In the chapter, I emphasize the
    conceptual similarities between different estimation strategies, but
    also try to point out differences between estimation strategies (and
    distinguish between fundamental differences and differences due to
    implementation choices made in different papers).

3)  A discussion of realistic issues that show up in empirical
    applications such as including covariates in the parallel trends
    assumption and dealing with violations of the parallel trends
    assumption.

4)  An extended application about minimum wage policies. My goal for the
    application was to (i) demonstrate different estimation strategies,
    and (ii) introduce open source code that is available for
    implementing new DID estimation strategies. The complete code/data
    that I used in the application is available
    [here](https://github.com/bcallaway11/did_chapter).

<script src="https://giscus.app/client.js"
        data-repo="bcallaway11/bcallaway11.github.io"
        data-repo-id="MDEwOlJlcG9zaXRvcnk3NDQyMTEyMQ=="
        data-category="Announcements"
        data-category-id="DIC_kwDOBG-Tgc4COCq4"
        data-mapping="pathname"
        data-reactions-enabled="1"
        data-emit-metadata="0"
        data-input-position="bottom"
        data-theme="light"
        data-lang="en"
        crossorigin="anonymous"
        async>
</script>
