#!/usr/bin/env bash

read -p "Email: " MAIL
ssh-keygen -t ed25519 -b 4096 -C "${MAIL}"
