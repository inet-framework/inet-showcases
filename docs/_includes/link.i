{% assign pg = site.pages | where: 'path', include.page | first %}
{% if pg == nil %}
  <li><strong>BOGUS LINK: No such page: {{include.page}}</strong></li>
{% elsif pg.hidden and site.showallpages != true  %}
  <!-- hidden: {{site.baseurl}}/{{pg.url}} -->
{% elsif pg.hidden and site.github %}
  <!-- hidden: {{site.baseurl}}/{{pg.url}} -->
{% else %}
 {% capture linkstyle %}{% if pg.hidden %}style="text-decoration: line-through;"{% endif %}{% endcapture %}
  <li><a href="{{site.baseurl}}/{{ pg.url }}" {{linkstyle}}>{{ pg.title }}</a></li>
{% endif %}
