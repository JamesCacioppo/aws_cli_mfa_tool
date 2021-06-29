# aws_cli_mfa_tool
![demo gif](demo.gif)

## Synopsis
In order to use the AWS CLI with an account configured for Multi-factor authentication the user must create a session and retrieve a session token then configure the CLI to use it.  This tool simplifies the process by creating a session with a 24 hour life and placing the credentials and session token in an environment file which can be sourced by the user.

## Prerequisites
* AWS CLI must be installed and authenticated
    * `aws configure`
    * Enter AWS Access Key ID, Secret Access Key, and a default region
* Retrieve your MFA devices arn
    * Log into the AWS Console
    * Click on your user name in the upper right corner
    * Select "My Security Credentials"
    * Find "Assigned MFA device" in the "Multi-factor authentication (MFA)" section and record the device arn.

## Usage
* Execute the script
* Enter the device arn if prompted for an "MFA serial number"
* Enter the one time token from your MFA device
* Source the generated environment file as shown by the script output
    * `. ~/.aws/session.env`