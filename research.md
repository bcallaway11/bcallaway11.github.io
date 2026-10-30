---
layout: single
title: Research
permalink: /research/
---

{% comment %}
  Papers are listed in _data/papers.yml and coauthor websites in
  _data/coauthors.yml; each entry is rendered by _includes/paper.html,
  wrapped in _includes/dated-entry.html for the year column.
{% endcomment %}

My papers on econometric methods for causal inference with panel data, along with some applications in labor economics. Slides, appendices, and code are linked under each paper where available. You can also check out my [Google Scholar](https://scholar.google.com/citations?user=VAFPcSgAAAAJ).

## Papers

{% comment %}
  Three views of the same papers, switched by the buttons below (script at
  the bottom of this page). Year is the default and shows without
  JavaScript. In both views the label column shows "Working" for working
  papers and the year for publications (the last comma-separated piece of
  `details` in papers.yml), once per group.
{% endcomment %}
{% assign all_papers = site.data.papers.working_papers | concat: site.data.papers.publications %}

<div class="sort-toggle" hidden>
  <span class="sort-toggle__label">Sort by:</span>
  <button type="button" class="sort-toggle__btn" data-view="year" aria-pressed="true">Year</button>
  <button type="button" class="sort-toggle__btn" data-view="topic" aria-pressed="false">Topic</button>
  <button type="button" class="sort-toggle__btn" data-view="selected" aria-pressed="false">Selected</button>
</div>

<div class="paper-list paper-list--dated" data-view-panel="year">
{% assign prev = "" %}
{% for p in all_papers %}
  {% if p.details %}{% assign year = p.details | split: ", " | last %}{% else %}{% assign year = "Working" %}{% endif %}
  {% if year != prev %}{% assign label = year %}{% else %}{% assign label = "" %}{% endif %}
  {% include dated-entry.html paper=p label=label %}
  {% assign prev = year %}
{% endfor %}
</div>

<div class="paper-list paper-list--dated" data-view-panel="topic" hidden>
{% for t in site.data.papers.topics %}
  <h3 class="topic-heading">{{ t.label }}</h3>
  {% assign group = all_papers | where: "topic", t.key %}
  {% assign prev = "" %}
  {% for p in group %}
    {% if p.details %}{% assign year = p.details | split: ", " | last %}{% else %}{% assign year = "Working" %}{% endif %}
    {% if year != prev %}{% assign label = year %}{% else %}{% assign label = "" %}{% endif %}
    {% include dated-entry.html paper=p label=label %}
    {% assign prev = year %}
  {% endfor %}
{% endfor %}
</div>

{% comment %} Papers flagged `selected: true` in papers.yml, in Year order {% endcomment %}
<div class="paper-list paper-list--dated" data-view-panel="selected" hidden>
  <p class="selected-note">My own picks for a quick sense of my research, mixing current projects with my best-known papers.</p>
{% assign group = all_papers | where: "selected", true %}
{% assign prev = "" %}
{% for p in group %}
  {% if p.details %}{% assign year = p.details | split: ", " | last %}{% else %}{% assign year = "Working" %}{% endif %}
  {% if year != prev %}{% assign label = year %}{% else %}{% assign label = "" %}{% endif %}
  {% include dated-entry.html paper=p label=label %}
  {% assign prev = year %}
{% endfor %}
</div>

{% comment %} Hidden by the script below in the Selected view {% endcomment %}
<div id="work-in-progress-section">
<h2 id="work-in-progress">Work in Progress</h2>
<div class="paper-list">
{% for p in site.data.papers.work_in_progress %}{% include paper.html paper=p %}{% endfor %}
</div>
</div>

<script>
  // Year/Topic/Selected switch for the Papers list. The toggle starts
  // hidden so visitors without JavaScript simply see the Year view. The
  // Selected view is a short list, so it also hides Work in Progress.
  (function () {
    var toggle = document.querySelector(".sort-toggle");
    if (!toggle) return;
    var buttons = toggle.querySelectorAll(".sort-toggle__btn");
    var panels = document.querySelectorAll("[data-view-panel]");
    var wip = document.getElementById("work-in-progress-section");
    function show(view) {
      panels.forEach(function (p) { p.hidden = p.getAttribute("data-view-panel") !== view; });
      if (wip) wip.hidden = view === "selected";
      buttons.forEach(function (b) { b.setAttribute("aria-pressed", b.getAttribute("data-view") === view); });
    }
    buttons.forEach(function (b) {
      b.addEventListener("click", function () { show(b.getAttribute("data-view")); });
    });
    toggle.hidden = false;
  })();
</script>
