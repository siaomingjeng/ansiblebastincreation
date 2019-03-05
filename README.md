# Deploy an Ansible Server into Azure using Stand_B2s VM Size and Existing Networks 

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fsiaomingjeng%2Fansiblebastincreation%2Fmaster%2Fansible_azure.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fsiaomingjeng%2Fansiblebastincreation%2Fmaster%2Fansible_azure.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/> 
</a>

## Parameter Explanations:
- Virtual Network Resource Group: The resource group of the existing virtual network;
- Virtual Network Name: The name of the existing virtual network;
- Subnet Name: The name the of the existing subnet;
- Admin Username: The Linux login username;
- SSH Public Key: The SSH public key used for login;
- Virtual Machine Name Base: The basename used to form the final VM/NIC/NSG name \'vm/nic/nsg-\<base\>-\<random string\>\';
- Script URL: The script to run once VM is provisioned;
- Ansible Version: The first parameter sent to script.


