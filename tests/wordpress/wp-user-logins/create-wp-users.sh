#!/bin/bash
dt=$(date +"%d%m%y-%H%M%S")
# Initialize default values
users=1
path="/var/www/html" # Default path to WordPress installation
domain="example.com" # Default email domain
backup_path="/root/tools/wpbackups" # Path to store backup files

# Function to show usage
usage() {
    echo "Usage: $0 -u <users> -p <path to WordPress installation> -d <email domain> -b <backup|restore>"
    echo "  -u: Number of WordPress users to create"
    echo "  -p: Full path to WordPress installation"
    echo "  -d: Target domain name for populating email domain"
    echo "  -b: Perform 'backup' or 'restore' operation"
    exit 1
}

# Check if WP CLI exists
if ! command -v wp >/dev/null; then
    echo "Error: WP CLI is not installed or not in the PATH. Please install it to continue."
    exit 1
fi

# Backup wp_users and wp_usermeta tables
backup_users() {
    # Table prefix
    table_prefix=$(wp config get table_prefix --path="$path" --allow-root)
    echo "Backing up users tables..."
    mkdir -p "${backup_path}"
    wp db export --tables="${table_prefix}users,${table_prefix}usermeta" --path="$path" --allow-root "${backup_path}/users_backup.sql"
    if [ $? -eq 0 ]; then
        echo "Successfully backed up users tables."
    else
        echo "Failed to back up users tables."
        exit 1
    fi
}

# Restore wp_users and wp_usermeta tables from backup
restore_users() {
    echo "Restoring users tables from backup..."
    wp db import "${backup_path}/users_backup.sql" --path="${path}" --allow-root
    if [ $? -eq 0 ]; then
        echo "Successfully restored users tables."
    else
        echo "Failed to restore users tables."
        exit 1
    fi
}

# Parse command-line options
while getopts "u:p:d:b:" opt; do
    case "${opt}" in
        u) users=${OPTARG};;
        p) path=${OPTARG};;
        d) domain=${OPTARG};;
        b) operation=${OPTARG};;
        *) usage;;
    esac
done

# Validate numeric value for users (only if creating users)
if [ -z "${operation}" ] || [ "${operation}" != "restore" ]; then
    if ! [[ "$users" =~ ^[0-9]+$ ]]; then
        echo "Error: Number of users must be a positive integer."
        usage
    fi
fi

# Change directory to WordPress installation path
if [ -d "${path}" ]; then
    echo "Changed directory to ${path}."
    cd "${path}"
else
    echo "Error: ${path} not found. Check the path and try again."
    usage
    exit 1
fi

# Create users using WP CLI (only if not performing backup or restore operation)
if [ -z "${operation}" ] || [ "${operation}" != "backup" ] && [ "${operation}" != "restore" ]; then
    for (( i=1; i<=users; i++ )); do
        wp user create "test${i}" "test${i}@${domain}" --role=subscriber --user_pass=3405691999 --allow-root
        if [ $? -eq 0 ]; then
            echo "Successfully created user test${i}"
        else
            echo "Failed to create user test${i}"
        fi
    done
    echo "Completed creating ${users} users."
elif [ "${operation}" == "backup" ]; then
    backup_users
elif [ "${operation}" == "restore" ]; then
    restore_users
else
    echo "Invalid operation. Use -b 'backup' or -b 'restore'."
    exit 1
fi
fi