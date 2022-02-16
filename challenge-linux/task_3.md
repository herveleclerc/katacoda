Azure Resources Groups are logical collections of virtual machines, storage accounts, virtual networks, web apps, databases, and/or database servers. Typically, users will group related resources for an application, divided into groups for production and non-production


In this task you must create a resource group in Azure with the following properties:

- name: `my-resource-group`
- location: `North Europe`

Once the resource group is created, get the properties of the resource group and output them to a file named `az-resource-group.txt`. 
  
💡 Tip: Don't forget to use the `-o tsv` parameter in your `az` command.