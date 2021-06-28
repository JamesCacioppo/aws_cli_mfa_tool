#!/bin/bash

function get_mfa() {
    if [ -f ~/.aws/aws_mfa_sn.txt ]; then
        . ~/.aws/aws_mfa_sn.txt
    else
        read -p "MFA serial number:" MFA_SN
        echo "MFA_SN=$MFA_SN" > aws_mfa_sn.txt
    fi

    read -p "MFA token:" MFA_TOKEN
}

function get_session_token() {
    echo "Retrieving session token."
    aws sts get-session-token --serial-number \
        $MFA_SN --token-code $MFA_TOKEN \
        > token.json

    ACCESS_KEY_ID=$(jq --raw-output .Credentials.AccessKeyId < token.json)
    SECRET_ACCESS_KEY=$(jq --raw-output .Credentials.SecretAccessKey < token.json)
    SESSION_TOKEN=$(jq --raw-output .Credentials.SessionToken < token.json)
}

function export_session() {
    echo "Exporting AWS session vars to ~/.aws/session.env"
    echo "ACCESS_KEY_ID=$ACCESS_KEY_ID" > ~/.aws/session.env
    echo "SECRET_ACCESS_KEY=$SECRET_ACCESS_KEY" >> ~/.aws/session.env
    echo "SESSION_TOKEN=$SESSION_TOKEN" >> ~/.aws/session.env
}

cd ~/.aws

get_mfa
get_session_token
export_session

echo "Don't forget to source the credentials file."
echo "Example:"
echo ". ~/.aws/session.env"