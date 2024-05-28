# cf-deployment
Scripts for deploying CloudFoundry on Linux and MaxOs Machine 

## Script for Ubuntu

1. Ensure you replace placeholders like your-bosh-director-ip, your-username, and your-password with actual values.

2. The --ca-cert option in bosh alias-env should point to your BOSH director's CA certificate. Adjust the path accordingly.

3. Make sure to authenticate with the BOSH director using the correct credentials.

By following these steps, you should be able to correctly set up and authenticate with your BOSH director, ensuring that the Cloud Foundry deployment proceeds successfully without issues.