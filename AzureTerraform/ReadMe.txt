High Level Steps to Onboaard Azure Connection in CASB IaaS
1. Create App in Azure - Refer CASB IaaS Public APIs for Onboarding Azure.docx
2. Create Azure Connection in CASB - Refer CASB IaaS Public APIs for Onboarding Azure.docx
3. Run Terraform Script
4. Run Public API's - Refer CASB IaaS Public APIs for Onboarding Azure.docx

This Document is to run terraform and deploy resources in Azure environment when user wants to onboard one or
more Azure subscriptions. This script will create event grid subscription for Subscription and add required permissions to Azure AD app.

Pre-requisites
On your local machine from where you want to run the terraform, you have to install following things:
1. Terraform Installation - https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
2. Azure AD app with required permissions for CloudSoc need to be created. The name of this app is referred in terraform variable.
3. User running the terraform should have following permissions on azure subscriptions
      1. EventGrid Contributor
      2. Role Assignment ('Microsoft.Authorization/roleAssignments/read','Microsoft.Authorization/roleAssignments/write','Microsoft.Authorization/roleAssignments/delete')
           with condition for 'Reader', 'Storage Blob Data Reader' roles and subscription scope

Steps:

1. CloudSoc Console - Configuring  Azure connection
    a. Log in to your CloudSoc account
    b. Goto Securlet and click on Microsoft Azure
    c. You will be routed to connections page
    d. Click on Add Connections and Select Azure
    e. You will be directed to Microsoft Azure Configuration page
    f. Give a connection name and save the connection
    g. Then press “Download PowerShell Script”. The script will be downloaded in your default folder.
    h. Copy following values from script and keep it handy.You can search for ("perpetual_token",
    "webhook_url", "cloudsoc_tenant_id") key word in shell script.
    This will be used later to run the terraform


2. Terraform files - Update variables
    Goto variable.tf file and replace these variables
    Update default values for following variables
        a. Replace perpetual_token in default value for delivery_property_value in delivery_properties variable
        b. webhook_url
        c. cloudsoc_tenant_id
        d. change app_name with azure AD app name created for CloudSoc
        e. Update variable azure_subscriptions_input with list of azure subscription ids which needs to be onboarded
           If this list is empty, all subscriptions where logged-in user has permission will be onboarded.

3. Run Terraform
    Once you have made the above changes then goto you local box command prompt
    Now type
        a. “terraform init” - this will initialize terraform environment
        b. “terraform plan” - this will output resources that terraform will create (kind of dry run)
        c. “terraform apply” - once you have run this it will start creating resources in the configured GCP environment







