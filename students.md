---
layout: single
title: Students
permalink: /students/
---

{% comment %}
  Students are listed in _data/students.yml and rendered by
  _includes/student.html. Names and paper titles pick up their links from
  _data/coauthors.yml and _data/papers.yml.
{% endcomment %}

Students I have advised or served on committees for, with their dissertations, placements, and our joint work.

## Ph.D. Main Advisor

<div class="paper-list">
{% for s in site.data.students.phd_advisor %}{% include student.html student=s %}{% endfor %}
</div>

## Ph.D. Dissertation Committee Member

<div class="paper-list">
{% for s in site.data.students.phd_committee %}{% include student.html student=s %}{% endfor %}
</div>

## M.A. Main Advisor

<div class="paper-list">
{% for s in site.data.students.ma_advisor %}{% include student.html student=s %}{% endfor %}
</div>
