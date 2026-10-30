---
layout: single
title: Posts
permalink: /posts/
---

{% comment %}
  Built automatically from _posts/. A post appears here when its front
  matter has `post_type: informal` or `post_type: summary`, plus an optional
  one-line `summary` and, for research summaries, a `paper_url`. Each entry
  is rendered by _includes/post-entry.html, newest first.
{% endcomment %}

## Informal Posts on Coding / Econometrics / Etc.

<div class="paper-list">
{% assign informal = site.posts | where: "post_type", "informal" %}
{% for p in informal %}{% include post-entry.html post=p %}{% endfor %}
</div>

## Short Research Summaries

<div class="paper-list">
{% assign summaries = site.posts | where: "post_type", "summary" %}
{% for p in summaries %}{% include post-entry.html post=p %}{% endfor %}
</div>
