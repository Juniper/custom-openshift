# Integrating Contrail with existing openshift-ansible

This is a simple playbook to append Contrail SDN roles to an existing openshift-ansible deplopyer

~~**For the current iteration, Please use the /home mount space to download the openshift-ansible code.** ~~


### Steps to execute 

**On the Openshift-ansible node**



**Step1: Download Openshift-ansible from your Openshift Repo**

```
eg:
sudo git clone https://github.com/openshift/openshift-ansible.git -b release-3.9
```


**Step3: Clone the custom-openshift repo** 
```
sudo git clone https://github.com/Juniper/custom-openshift.git
```
**Step4: Go to the playbook Directory and execute the playbook** 


```
cd custom-openshift/ose/playbooks/

**command to run**


ansible-playbook integrate.yaml -e src_directory={{path to openshift-ansible}} -e dst_directory={{path to download contrail-openshift-repo}}

[root@ip-10-10-10-10 playbooks]# ansible-playbook integrate.yaml -e src_directory=/usr/share/ansible/openshift-ansible -e dst_directory=/tmp/test2/
 [WARNING]: provided hosts list is empty, only localhost is available. Note that the implicit localhost does not
match 'all'

PLAY [127.0.0.1] ************************************************************************************************

TASK [Gathering Facts] ******************************************************************************************
ok: [127.0.0.1]

TASK [pull the latest openshift-contrail-code from git] *********************************************************
ok: [127.0.0.1]

TASK [copy contrail_master into your openshift-ansible-deployer] ************************************************
changed: [127.0.0.1]

TASK [copy contrail_nodes folder into your openshift-ansible-deployer] ******************************************
changed: [127.0.0.1]

TASK [Set permissions for replacement master config files] ******************************************************
changed: [127.0.0.1]

TASK [Execute the script] ***************************************************************************************
changed: [127.0.0.1]

TASK [Set permissions for replacement node config files] ********************************************************
changed: [127.0.0.1]

TASK [Execute the script] ***************************************************************************************
changed: [127.0.0.1]

TASK [Set permissions for replacement node config files] ********************************************************
changed: [127.0.0.1]cement contrail config files] ****************************************************
changed: [127.0.0.1]

PLAY RECAP ******************************************************************************************************
127.0.0.1                  : ok=11   changed=9    unreachable=0    failed=0   

[root@ip-10-10-10-10 playbooks]#
```

**Step5 : Verify if contrail code has been appended to the Openshift-playbooks**

```
[root@ip-10-10-10-10 playbooks]# cd /usr/share/ansible/openshift-ansible/
[root@ip-10-10-10-10 openshift-ansible]# 
[root@ip-10-10-10-10 openshift-ansible]# git status
```

**Step6 : Please append the contrail inventory variables to your openshift-asible inventory**
```
---
openshift_use_openshift_sdn: False
os_sdn_network_plugin_name: 'cni'
nested_mode_contrail: False
openshift_use_contrail: True
contrail_version: 5.0
contrail_container_tag: 5.0.2-0.360
contrail_registry_insecure: True
contrail_registry: hub.juniper.net/contrail
contrail_registry_username: <change-me>
contrail_registry_password: <change-me>
# Please provide the Kubernetes VIP or Load Balancer as a IP address, Please not URL will not work.  
kubernetes_api_server: <Openshift VIP IP addresss>  
service_subnets: 172.30.0.0/16

# openshift_node_open_ports: [
#   { "service":"contrail-config-api", "port":"8082/tcp" },
#   { "service":"contrail-config-api-backend", "port":"9100/tcp" },
#   { "service":"contrail-config-api-introspect", "port":"8084/tcp" },
#   { "service":"contrail-web-ui", "port":"8143/tcp" },
#   { "service":"contrail-web-ui-debug", "port":"8080/tcp" },
#   { "service":"contrail-control-xmpp", "port":"5269/tcp" },
#   { "service":"contrail-control-dns-xmpp", "port":"8093/tcp" },
#   { "service":"contrail-control-introspect", "port":"8083/tcp" },
#   { "service":"contrail-kubemanager-introspect", "port":"8108/tcp" },
#   { "service":"contrail-vrouter-introspect", "port":"8085/tcp" },
#   { "service":"contrail-control-introspect-dns", "port":"8092/tcp" },
#   { "service":"contrail-analytics-collector", "port":"8086/tcp" },
#   { "service":"contrail-schema-transformer-introspect", "port":"8087/tcp" },
#   { "service":"contrail-analytics-api", "port":"8081/tcp" },
#   { "service":"zookeeper", "port":"2181/tcp" },
#   { "service":"zookeeper-analytics", "port":"2182/tcp" },
#   { "service":"zookeeper-range", "port":"2888-3889/tcp" },
#   { "service":"zookeeper-analytics-range", "port":"4888-5888/tcp" },
#   { "service":"rabbitmq", "port":"5672/tcp" },
#   { "service":"redis", "port":"6379/tcp" },
#   { "service":"kafka", "port":"9092/tcp" },
#   { "service":"cassandra9041", "port":"9041/tcp" },
#   { "service":"cassandra9042", "port":"9042/tcp" },
#   { "service":"cassandra9160", "port":"9160/tcp" },
#   { "service":"cassandra9161", "port":"9161/tcp" },
#   { "service":"cassandra7000", "port":"7000/tcp" },
#   { "service":"cassandra7010", "port":"7010/tcp" },
#   { "service":"cassandra7199", "port":"7199/tcp" },
#   { "service":"cassandra7198", "port":"7198/tcp" },
#   { "service":"ifmap", "port":"8443/tcp" },
#   { "service":"rabbit-ha-port4369", "port":"4369/tcp" },
#   { "service":"rabbit-ha-port25672", "port":"25672/tcp" },
#   { "service":"contrail-vrouter-agent-introspect", "port":"8085/tcp" },
#   { "service":"contrail-cni", "port":"9091/tcp" },
#   { "service":"dns", "port":"53/tcp" }
# ]


#**Add this contrail vars list**
[contrail_masters]
10.10.10.10 openshift_hostname=ip-10-10-10-10.us-west-1.compute.internal
```
