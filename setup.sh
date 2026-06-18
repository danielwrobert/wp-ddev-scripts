#!/usr/bin/env bash

set -euo pipefail

YELLOW=$'\e[1;33m'
GREEN=$'\e[1;32m'
NOCOLOR=$'\e[0m'
currentdir=${PWD##*/}
siteurl=$(ddev exec 'echo $DDEV_PRIMARY_URL')
woocommerce=false

echo "${YELLOW}Setting up the DDEV project...${NOCOLOR}"
ddev config --project-type=wordpress

echo "${YELLOW}Starting DDEV...${NOCOLOR}"
ddev start -y

echo "${YELLOW}Grabbing the latest version of WordPress...${NOCOLOR}"
ddev wp core download

echo "${YELLOW}Installing WordPress...${NOCOLOR}"
read -p "Please enter the site title (default = ${currentdir}): " title
title=${title:-${currentdir}}
read -p "Please enter the admin username (default = admin): " username
username=${username:-admin}
read -p "Please enter the admin password (default = admin): " userpass
userpass=${userpass:-admin}
read -p "Please enter the admin email (default = example@example.com): " useremail
useremail=${useremail:-example@example.com}
ddev wp core install --url="$siteurl" --title="$title" --admin_user="$username" --admin_password="$userpass" --admin_email="$useremail"

# The following WooCommerce items rely on the WP-CLI ext: https://github.com/nielslange/woo-test-environment.
read -p "Is this a WooCommerce project? [Y/n] " -n 1

if [[ $REPLY =~ ^[Yy]$ ]]; then
	woocommerce=true
fi

if [[ $woocommerce == true ]]; then
	# Check if the WP-CLI command is installed.
	ddev wp woo-test-environment &>/dev/null
	if [ $? -ne 0 ]; then
		echo "${YELLOW}You must have the woo-test-environment command installed. Installing...${NOCOLOR}"
		ddev wp package install git@github.com:nielslange/woo-test-environment.git
	fi
	echo "${YELLOW}Setting up WooCommerce...${NOCOLOR}"
	ddev wp woo-test-environment setup
fi

echo "${GREEN}Project setup complete! Launching WP-Admin in the browser 🚀${NOCOLOR}"
ddev launch wp-admin/