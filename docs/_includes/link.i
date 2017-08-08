<li>
  {% assign pg = site.pages | where: 'path', include.page | first %}
  {% if pg == nil -%}
    BOGUS LINK: No such page: {{include.page}}
  {% else %}
    <a href="{{site.baseurl}}/{{ pg.url }}">{{ pg.title }}</a>
  {% endif %}
</li>
