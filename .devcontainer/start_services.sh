#!/bin/bash

# Check whether in directory containing html
if [ ! -d ${PWD}/html ]; then
    echo "Please run from the directory where html is located!"
    exit
fi

# Figure out who I am
myself=$(whoami)

# Start MariaDB
tmpfile=$(mktemp)
cat > ${tmpfile} << EOF
#!/bin/bash
mariadbd-safe
nohup mariadbd --user=mysql >& /dev/null &
EOF
chmod +x ${tmpfile}
echo "Running MariaDB daemon in safe mode for 3 seconds..."
sudo nohup ${tmpfile} >& /dev/null &
# Time to do something as regular user (with sudo)
sleep 3
echo "Shutting down Mariab DB daemon in safe mode..."
echo SHUTDOWN | sudo mariadb -u root
rm ${tmpfile}
echo "MariaDB should be running now"
echo ""

# Start Apache
if [ -d /var/www/html ]; then
    echo "Setting up Apache HTML directory"
    sudo rm -rf /var/www/html
    sudo ln -s ${PWD} /var/www/html
fi
sudo /usr/sbin/apachectl start
echo "Apache should be running op port 8081"
