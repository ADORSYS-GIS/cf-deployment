# Update Guide for Cloud Foundary version 6.44.1 - 8.7.10

## Introduction
Cloud Foundry (CF) is an open-source platform as a service (PaaS) that provides a streamlined process for deploying, managing, and scaling applications. It abstracts the complexities of the underlying infrastructure, allowing developers to focus on coding. CF is known for its multi-cloud support, ease of use, and support for various programming languages and frameworks.
Major Changes from Cloud Foundry v6 to v8.<br>
The goal of this document is to bring out the new features, fixes and bugs which have occured from the cloud foundary CLI from version ```6.44.1``` - ```8.7.10```, and brings out 
the script adjustments for this changes inother to avoid breaking changes.
##                                   Upgrading to version 7.7.10

### Major changes from version 6 to version 7
#### New feautes supported by cloud foundary version 7 not found found in version 6 (Breaking Changes)
  
- it uses **CAPI** v3 (cloud controller api) which over develops granular control over thier apps, It activates the new workflows by exposing packages, droplets, builds and processes.
  
- ***Rolling App Deployments*** push updates without incurring down time.
- ***Running cloud foundary sub-step commands*** these commands breakdown the cloud foundary push process into sub steps that can run independently.
- ***Pushing with multiple processes*** Use a single command to push apps that run multiple processes. An example is a web app that has a UI process.
- ***Pushing Apps with sidecar processes*** Run additional processes in the same container as your APP.
- ***Using Metadata*** Add metadata to objects for example, spaces and apps. This helps with operating, Monitoring and auditing.

### Command Differences between V6.44.0 - v7.7.10

|version 6                                  |version 7                                             |Script Adjustments                    |
|-------------------------------------------|------------------------------------------------------|---------------------------------------
|wraps error messages received from the CAPI| returns raw messages as received from the source for better debugging | Scripts that depend on the format or specific content or error message should be adjust to handle raw error messages from the api|
||cloud foundry CLI v7 outputs errors and warnings to stderr rather than stdout for simplicity of debugging|Scripts should handle error logging to stderr insteadof stdout|
||Updates in styling and descriptive text making it more user friendly|**ressource name**,**ORG name**, **user name** and **space name** are in cyan<br>**ok**- green<br>**Fail**- red<br> **Warning error messages**, **Tip** in plaintext,see more [here](https://github.com/cloudfoundry/cli/wiki/CLI-Product-Specific-Style-Guide#prompts)|
||When and error occurs the name of the resource will appear in single quotes| scripts should handle error logging for ressource name to appear in single quotes|
||key-value and table columns headers are displayed in lowercase<br> and also ensures endempotency by consistent exit codes| key-value and table columns should be displayed in lowercase<br> 0 for no change, 1 for failure|
### Table of Differences in version 7.7.10
| **Command**                       | **Added/New Flag**                     | **Updates**                                                                                             | **Removed**                                                  |
|-----------------------------------|----------------------------------------|--------------------------------------------------------------------------------------------------------|--------------------------------------------------------------|
| ```cf add-network-policy```             |                                        |                                                                                                        | --destination-app (destination app is now a required argument) |
| ```cf apps```                           |                                        | Displays information about processes, url field renamed to routes, removed instances, memory, disk info, apps listed alphabetically |                                                              |
| ```cf bind-security-group```            |                                        | SPACE is no longer an argument; use the --space flag                                                   |                                                              |
| ```cf check-route```                    | --hostname                             | HOST is no longer a required argument, no longer requires a backslash                                   |                                                              |
| ```cf create-buildpack```               |                                        | Creating a buildpack with position set to 0 is no longer valid                                          | --enable, --disable                                           |
| ```cf create-domain```                  |                                        |                                                                                                        | Renamed to create-private-domain                             |
| ```cf create-org```                     |                                        | Requires clients.read scope (or clients.admin, or zones.uaa.admin) when logged in using client credentials |                                                              |
| ```cf create-quota```                   |                                        |                                                                                                        | Renamed to create-org-quota                                  |
| ```cf create-space```                   |                                        | Requires clients.read scope (or clients.admin, or zones.uaa.admin) when logged in using client credentials |                                                              |
| ```cf create-route```                   |                                        | SPACE is no longer a required argument; creates a route in the targeted space                           | --random-port (default behavior for routes with TCP domains) |
| ```cf create-service-auth-token```      |                                        |                                                                                                        | Command removed                                              |
| ```cf create-service-broker```          |                                        | Creates a service broker object even if command does not complete all phases                            |                                                              |
| ```cf create-user```                    | --password-prompt                      |                                                                                                        |                                                              |
| ```cf delete```                         |                                        | -r no longer deletes routes when the route is mapped to more than one app                               |                                                              |
| ```cf delete-domain```                  |                                        |                                                                                                        | Renamed to delete-private-domain                             |
| ```cf delete-org```                     |                                        | Command fails if the org contains shared private domains                                               |                                                              |
| ```cf delete-quota```                   |                                        |                                                                                                        | Renamed to delete-org-quota                                  |
| ```cf delete-service-auth-token```      |                                        |                                                                                                        | Command removed                                              |
| ```cf domains```                        |                                        | Status column renamed to availability, refers to private domains with private instead of own            |                                                              |
| ```cf files```                          |                                        |                                                                                                        | Command removed                                              |
| ```cf map-route```                      |                                        |                                                                                                        | --random-port (default behavior for TCP routes)              |
| ```cf marketplace```                    |                                        | When the -e flag is specified, plan costs advertised by the service broker are displayed, exit code 0 if no service offering found | -s flag renamed to -e                                       |
| ```cf migrate-service-instances```      |                                        |                                                                                                        | Command removed                                              |
| ```cf packages```                       |                                        | Displays packages from most recent to least recent                                                     |                                                              |
| ```cf push```                           | --strategy, --no-wait, --endpoint      | --health-check-type none is removed, --no-route no longer unbinds all existing routes, -t now has a long form --app-start-timeout | --route-path, -d, --no-hostname, --hostname                  |
| ```cf purge-service-offering```         |                                        |                                                                                                        | -p flag removed                                              |
| ```cf quota```                          |                                        |                                                                                                        | Renamed to org-quota                                         |
| ```cf quotas```                         |                                        |                                                                                                        | Renamed to org-quotas                                        |
| ```cf remove-network-policy```          |                                        |                                                                                                        | --destination-app (destination app is now a required argument)|
| ```cf rename-buildpack```               |                                        |                                                                                                        | Command removed (use --rename flag with cf update-buildpack) |
| ```cf restart-app-instance```           | --process                              |                                                                                                        |                                                              |
| ```cf routes```                         |                                        | Port, type, and service no longer appear in the table                                                  | --orglevel renamed to --org-level                            |
| ```cf run-task```                       | --command, --process                   | COMMAND is no longer an argument                                                                       |                                                              |
| ```cf scale```                          | --process                              |                                                                                                        |                                                              |
| ```cf service-access```                 |                                        | Displays space and org for service offerings from a space-scoped service broker                         |                                                              |
| ```cf service-auth-tokens```            |                                        |                                                                                                        | Command removed                                              |
|```cf set-health-check``               | --process, --invocation-timeout        |                                                                                                        |                                                              |
| ```cf set-quota```                      |                                        |                                                                                                        | Renamed to set-org-quota                                     |
| ```cf set-running-environment-variable-group``` |                               | System environment variables can only be strings (API enforced)                                        |                                                              |
| ```cf set-staging-environment-variable-group``` |                               | System environment variables can only be strings (API enforced)                                        |                                                              |
| ```cf ssh```                            | --process                              |                                                                                                        |                                                              |
| ```cf start```                          |                                        | Improved behavior for staging and starting apps                                                        |                                                              |
| ```cf unshare-private-domain```         |                                        | Provides a warning and requires confirmation before proceeding                                         |                                                              |
| ```cf update-buildpack```               | --rename                               | --unlock and --path are now compatible                                                                 |                                                              |
| ```cf update-quota```                   |                                        |                                                                                                        | Renamed to update-org-quota                                  |
| ```cf update-service-auth-token```      |                                        |                                                                                                        | Command removed                                              |
| ```cf v3-COMMAND```                     |                                        | v3 prefixes removed (commands now use CAPI V3 by default)                                              |                                                              |
| ```cf apply-manifest```                 |                                        | Defaults to using the manifest located in the current working directory if no flags are passed          |                                                              |
| ```cf v3-cancel-zdt-push```             |                                        |                                                                                                        | Command removed (use cf cancel-deployment)                   |
| ```cf v3-zdt-push```                    |                                        |                                                                                                        | Command removed (use --strategy rolling flag with cf push)   |
| ```cf buildpacks```                     |                                        | Order of columns changed, buildpack column header renamed                                              |                                                              |


## Upgrading from version 6.44.1 To version 8.7.10

### New Workflows supported by cloud foundry version 8
***Asynchronous operations*** All services-related operations are now asynchronous by default. This includes manipulating service keys and route bindings in cloud foundry version 8. Golang has been updated from ```v1.13``` to ```v1.16```.

### Command differences between version 7.7.10 - version 8.7.10
***Manifest diff not provided*** when using cloud foundry CLI v8 running ```cf push``` does not show the difference between the current app state and the new manifest through the v3 manifest diff endpoint.

|v7|v8|Script Adjustments|
|--|--|------------------|
||cloud foundry CLI v8 uses CAPI v3 to make requests to services, CAPI v3 creates asynchrounous jobs if you want to continue to create jobs asynchrounouly use the ```--await``` flag| To Handle the new asynchrounous jobs behaviours you should add the --await flag to the relevant commands|

### Table of Differences in version 8.7.10
|command|Added/New flag | updates | Remove | Script Adjustments|
|-------|---------------|---------|--------|-------------------|
|```cf bind-service```|```--await``` for the bind operation to complete|||Handle asynchronous operations by adding --await for the bind of cloud foundry services|
|```cf bind-route-service```|```--wait``` to wait for the create operation to complete.|Bind route operation is asynchronous by default||Handle bind route operation in async as before|
|```cf create-service```||```--await``` to wait for the create operation to complete||create operation should await using --await|
|```cf delete-serivce```||delete operation is asynchronous by default||Script should make delete operation asynchrounous by default|
|```cf map-route```|added ```--destination-protocol```to use HTPP/2 to communicate with apps<br>By default, if destination-protocol is not set, HTTP/1 protocol is used for HTTP route.|||Script should handle --destination-protocol to require ressource|
|```cf market place```|```--show-unavailable``` to show plans that are not available for use|||CLI should handle --show-unavailable to show unavailable plans.|
|```cf route``` | New command for viewing details about a route and its destinations|||create a new CLI ```cf route```|
|```cf routes```|Added ```service instance``` column to output|||cf routes should add service instance column to output|
|```cf service```|use ```--params```to retrieve and display the given service instance's parameters as JSON. All other outputs is suppressed|displys info **guid**, **type**, and **broker tags**<br>**dashboard** field is renamed to **dashboard url**<br>. Minor changes to the ordering and wording of each block of information.||**--params** should display the given service instance's parameters as JSON<br>.should display info about guid, type and broker tags<br>. Update the service broker field|
|```cf service-key```||Displays information about the last operation and message as new columns||last operations and messages should be displayed in new columns|
|```cf services```| use ```--no-apps``` donot receive bound apps info<br>.```--await``` to wait for operations|||CLI should include ```--no-apps``` option|
|```cf unbind-service```|Use --wait to wait for the unbind operation to complete.|||unbind operations should be asynchronous by default|
|```cf unbind-route-service```|Use --wait to wait for the unbind operation to complete.|unbind route operation is asynchronous by default||make unbind operation asynchronous|
|```cf update-service```|Use --wait to wait for the unbind operation to complete.||--upgrade. Use new command cf upgrade-service to upgrade a plan|service update should be asynchronous by default|
|```cf upgrade-service```|||```-force```. There is no longer user interaction required on this command.|remove --force flag theris no longer use interaction required on this command|

## Patches from version 6.44.1 - version 8.7.10
|Changes/Patches|Script adjustment|
|------|-----------------|
|update ```Ginkgo``` to version 2 | update test scripts to be compatible with Ginkgo v2|
|added ```--redact-env``` flag to ```cf-push``` command to enhance security by preventing unitensional exposure of secrets| scripts should add ```redact-env```|
| added support for authentication on the cli using ```-u``` for username and ```-p``` for password| script should handle ```cf login -u``` when working with kubernetes|
|upgrade go from version ```1.20``` to version ```1.21```| script should handle this upgrade without breaking things|
|creating private domain does'nt fail when domain already exits| script should gracefull handle creation of private domains which already exits|
|Remove eventually statement when enabling ssh Tip| Eventually statement should be removed when from script when enabling ssh Tip|
|SSH access does not work after enabling it, because it requires a restart.|```enable-ssh``` requires a restart of the app to work.|
|Added AWS Role ARN to access S3||
|Updated CAPI S3 location|removed s3 account from AWS|
|updated **protobuf** from version ```1.30.0``` to version ```1.31.0```| handle this upgrade accross scripts|
|use latest ruby buildpacks for capi test| add latest ruby buildpacks|
|credentials are specified via interactive prompts and environment variables|```cf auth``` and ```cf login``` should allow user credentials to be specified via prompt and environment variables|
|Added a ```--update-if-exists``` flag to the CF|script should use make use ```--update-if-exists``` in the CLI for better user experience|
|added GetTaskRequest|script should add GetTaskRequest as [here](https://github.com/cloudfoundry/cli/pull/2343/files)|
