{% assign pg = site.pages | where: 'path', include.page | first %}
{% if pg == nil %}
  <li><strong>BOGUS LINK: No such page: {{include.page}}</strong></li>
{% elsif pg.hidden and site.showallpages != true %}
  <!-- nothing -->
{% else %}
  <li><a href="{{site.baseurl}}/{{ pg.url }}">{{ pg.title }}</a>{% if pg.hidden %} (hidden){% endif %}</li>
{% endif %}
