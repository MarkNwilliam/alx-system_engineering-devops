#!/bin/bash

# Check if password is supplied
if [ $# -ne 1 ]; then
    echo "Usage: $0 <mysql root password>"
    exit 1
fi

# MySQL root password
password=$1

# Get date elements
day=$(date +%d)
month=$(date +%m)
year=$(date +%Y)

# MySQL dump filename
dump_file="backup.sql"

# Archive filename
archive_file="${day}-${month}-${year}.tar.gz"

# Dump all databases
mysqldump -u root -p$password --all-databases > $dump_file

# Compress the dump file into a tar.gz archive
tar -czvf $archive_file $dump_file

# Remove the dump file
rm $dump_file
