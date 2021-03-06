#!/usr/bin/env bash

openssl aes-256-cbc -K $encrypted_cdaf52794220_key -iv $encrypted_cdaf52794220_iv -in .travis/signing.gpg.enc -out signing.gpg -d
gpg --import signing.gpg

GPG_EXECUTABLE=gpg mvn -B -q -DskipTests -s ./.travis/settings.xml  -pl ./,crd-generator,api -P ossrh clean package gpg:sign deploy

rm -rf signing.gpg
gpg --delete-keys
gpg --delete-secret-keys