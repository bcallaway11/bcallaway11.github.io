---
layout: single
title: Code
permalink: /code/
---

{% comment %}
  Packages are listed in _data/software.yml; each entry is rendered by
  _includes/software.html.
{% endcomment %}

## Main Packages

These are the main packages that I have developed and actively maintain.

<div class="paper-list">
{% for s in site.data.software.main %}{% include software.html pkg=s %}{% endfor %}
</div>

## Utility Packages

Smaller packages that serve a specific purpose.

<div class="paper-list">
{% for s in site.data.software.utility %}{% include software.html pkg=s %}{% endfor %}
</div>

## Additional Packages

These are packages developed for specific projects. They are functional, but not as general purpose as the packages above, and I am not actively maintaining them.

<div class="paper-list">
{% for s in site.data.software.additional %}{% include software.html pkg=s %}{% endfor %}
</div>
