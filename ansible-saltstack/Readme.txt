#ansible
#mv ansible.cfg ./ansible
cd ansible
ansible-playbook -v install.yml
ansible-playbook -v zooconf.yml

#saltstak
mv saltstack  /srv/salt/
sudo salt zoonode*  state.sls saltstack.install
sudo salt zoonode*  state.sls saltstack.config