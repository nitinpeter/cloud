
{% set kafkaversion = pillar.get('kafkaversion','2.1.0') %}
{% set confluentversion = pillar.get('confluentversion','5.1.0') %}

#chattr_i:
#  cmd.run:
#    - name: chattr -i /etc/yum.repos.d
kafka_repo:
  file.managed:
    - name: /etc/yum.repos.d/confluent.repo
	- source: salt://confluent/templates/confluent.repo
	- user: root
	- user: root
	- mode: 644

confluent_group:
  group.present:
    - name: confluent
	- gid: 606

confluent_user:
  user.present:
    - name: confluent
	- fullname: confluent
	- shell: /bin/bash
	- home: /home/{{ user }}
	- uid: 606
	- gid: 606
	- groups:
	  - confluent

confluent_lvm:
  lvm.lv_present:
    - name: lv_conf
	- vgname: vg00
    - size: 5G
confluent_lvm_format:
  blockdev.formatted:
    - name: /dev/mapper/vg00-lv_conf
	- fs_type: xfs
/var/lib/confluent:
  mount.mounted:
    - device: /dev/mapper/vg00-lv_conf
	- fstype: xfs
	- mkmnt: True
	- opts:
	  - defaults

confluent-installl:
  pkg.install:
    - name: confluent-community-{{ confluentversion }}
	- enablerepo: confluent
	