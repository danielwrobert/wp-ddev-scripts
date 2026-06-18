#!/usr/bin/env bash
set -euo pipefail
mkdir -p my-wp-cli-site && cd my-wp-cli-site
ddev config --project-type=wordpress
ddev start -y
ddev wp core download
ddev wp core install --url='$DDEV_PRIMARY_URL' --title='My WordPress site' --admin_user=admin --admin_password=admin --admin_email=admin@example.com
ddev launch wp-admin/