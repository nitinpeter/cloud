{% set host =  grains['host'] %}
{% set myid = { host: grains.get('myid')} %}
{% set zoocluster= [] %}
{% set config = pillar.get('zookeeper') %}
{% for server,address in salt[mine.get]('zoonode*','cmd.run') | dictsort %} {% do zoocluster.append(address) %}
{% if host in address %}{% if not myid%} {% do myid.update({host:loop.index}) %}{% endif %}{% endif %}
{% endfor %}


include:
  - confluent.install


zookeeperfile:
  file.managed:
    - name: /etc/confluentkafka/zookeeper.properties
	- source: salt://confluent/zookeeper.properties
	- template: jinja
	- context:
	   myid: {{ myid[host] }}
	   zoonodes: {{ zoocluster }}
	   config: {{ config}}