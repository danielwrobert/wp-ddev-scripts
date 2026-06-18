# DDEV Scripts for Local WordPress Development

This repository contains scripts and configurations to facilitate local WordPress development using DDEV.

## Prerequisites

- [Docker](https://www.docker.com/get-started) installed on your local machine.
- [DDEV](https://ddev.readthedocs.io/en/stable/) installed on your local machine.
- [WP-CLI](https://wp-cli.org/) installed on your local machine.

## Installation

Install using the setup script (`setup.sh`) provided in this repository.

This script will create a new WordPress site in a DDEV environment.

The `setup.sh` script:

```bash
#!/usr/bin/env bash
set -euo pipefail
mkdir -p my-wp-cli-site && cd my-wp-cli-site
ddev config --project-type=wordpress
ddev start -y
ddev wp core download
ddev wp core install --url='$DDEV_PRIMARY_URL' --title='My WordPress site' --admin_user=admin --admin_password=admin --admin_email=admin@example.com
ddev launch wp-admin/
```
Ensure the `setup.sh ` script has executable permissions:

```bash
chmod +x setup.sh
```

Then run the script:

```bash
sh ./setup.sh
```

Reference: https://docs.ddev.com/en/stable/users/quickstart/#wordpress

## Scripts

The scripts provided in this repository need to be added to the `commands/web` folder of your DDEV project. You can create the folder if it doesn't exist.

## Git Ignore File

Use the `.gitignore` file provided in this repository to ignore unnecessary files and directories in your DDEV project.
