#!/bin/bash
# Description :- Notify by mail that backup is completed
# Author : Amit Kumar Mishra
# Requirement : AWS CLI

. ./svnbk.cfg
aws ses send-email --from "$FROM" --to "$TO" --subject "$SUB" --text "$BODY"