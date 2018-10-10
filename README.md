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
openshift_use_openshift_sdn=false
os_sdn_network_plugin_name='cni'
openshift_use_contrail=true
contrail_version=5.0
contrail_container_tag=5.0.1-0.214
contrail_registry_insecure=true
contrail_registry=hub.juniper.net/contrail
# Username /Password for private Docker registry
#contrail_registry_username=test
#contrail_registry_password=test
#vrouter_gateway=10.10.10.1

#**Add this contrail vars list**
[contrail_masters]
10.10.10.10 openshift_hostname=ip-10-10-10-10.us-west-1.compute.internal
```
