#!/bin/sh

echo 'check terraform files format'
terraform fmt -check -recursive

echo 'validate terraform files'
terraform validate

echo 'done linting'
