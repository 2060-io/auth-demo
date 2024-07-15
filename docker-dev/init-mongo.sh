#!/bin/bash

response=$(curl -s 'http://localhost:5000/clients/')

if [ "$response" = "[]" ]; then
  echo "The array is empty. Performing POST for clients..."
  curl -X 'POST' \
    'http://localhost:5000/clients/' \
    -H 'accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{
      "client_id": "keycloak",
      "client_name": "keycloak",
      "client_secret": "**********",
      "response_types": [
        "code",
        "id_token",
        "token"
      ],
      "token_endpoint_auth_method": "client_secret_basic",
      "redirect_uris": [
        "http://localhost:8880/auth/realms/vc-authn/broker/vc-authn/endpoint"
      ]
    }'
  echo ""
  echo "POST for clients successful."
else
  echo "The array is not empty. No POST performed."
fi

response=$(curl -s 'http://localhost:5000/ver_configs/')

if [ "$response" = "[]" ]; then
  echo "Performing POST for ver_configs..."
  curl -X 'POST' \
    'http://localhost:5000/ver_configs/' \
    -H 'accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{
      "ver_config_id": "phone-number",
      "subject_identifier": "",
      "generate_consistent_identifier": true,
      "include_v1_attributes": true,
      "proof_request": {
        "name": "Chatbot demo phone number",
        "version": "1.0",
        "requested_attributes": [
          {
            "names": ["phoneNumber"],
            "restrictions": [
              {
                "cred_def_id": "did:web:chatbot-demo.dev.2060.io?service=anoncreds&relativeRef=/credDef/8TsGLaSPVKPVMXK8APzBRcXZryxutvQuZnnTcDmbqd9p"
              }
            ]
          }
        ],
        "requested_predicates": []
      }
    }'
  echo ""
  echo "POST for ver_configs successful."
else
  echo "The array is not empty. No POST performed."
fi
