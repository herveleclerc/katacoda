Azure Virtual Network (VNet) is the fundamental building block for your private network in Azure. VNet enables many types of Azure resources, such as Azure Virtual Machines (VM), to securely communicate with each other, the internet, and on-premises networks. VNet is similar to a traditional network that you'd operate in your own data center, but brings with it additional benefits of Azure's infrastructure such as scale, availability, and isolation.


more information here [virtual-network](https://docs.microsoft.com/en-us/azure/virtual-network)


In this task you must create a Vnet in Azure with the following properties:

- name: `my-vnet`
- resource group: `my-resource-group`
- Vnet address space: `10.0.0.0/16`
- First subnet name: `my-subnet-1`
- Subnet address space: `10.0.0.0/24`


Once the vnet is created, get the ID of the Vnet and output it to a file named `az-vnet.txt`. 

💡 Tip: You can use the `--query` parameter to get the ID of the Vnet. or `awk` to get the ID of the Vnet.





