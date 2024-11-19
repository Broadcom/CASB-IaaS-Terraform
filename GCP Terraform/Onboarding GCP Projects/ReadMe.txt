This Document is to run terraform and deploy resources in GCP environment when user wants to onboard one or
more GCP Projects

Pre-requisites
On your local machine from where you want to run the terraform, you have to install following things:
1. Terraform Installation - https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
2. Install and configure gcloud - Set up Application Default Credentials for your gcp_project_id

Steps:

1. CloudSoc Console - Configuring  GCP connection
    a. Log in to your CloudSoc account
    b. Goto Securlet and click on Google Cloud
    c. You will be routed to connections page
    d. Click on Add Connections and Select GCP
    e. You will be directed to GCP Configuration page
    f. Give a connection name and save the connection
    g. Then press “Download Shell Script”. The script will be downloaded in your default folder.
    h. Copy following values from script and keep it handy.You can search for ("cloudSocConnectionId",
    "cloudSocWebhookUrl", "cloudSocPerpetualToken", cloudSocTenantId" and "broadcomScanAccount") key word in shell script.
    This will be used later to run the terraform


2. Terraform files - Update variables
    Goto variable.tf file and do the following, you can use the above table to do replace these variables
    Update default values for variables
        a. gcp_project_id
        b. region
        c. cloudSocConnectionId
        d. cloudSocWebhookUrl
        e. cloudSocPerpetualToken
        f. cloudSocTenantId
        g. broadcomScanAccount

3. Run Terraform
    Once you have made the above changes then goto you local box command prompt
    Now type
        a. “terraform init” - this will initialize terraform environment
        b. “terraform plan” - this will output resources that terraform will create (kind of dry run)
        c. “terraform apply” - once you have run this it will start creating resources in the configured GCP environment

Note:-
After successful resource deployment, Copy and save the serviceAccountID created.
This serviceAccountID will be used to run the GCP Public API to create the connection and onboard the accounts.
Use the document CASB IaaS Public APIs for onboarding GCP Accounts to run GCP Public API to





