#!/bin/bash
# Salt-Minion Run Script
#

set -e

# Log Level
LOG_LEVEL=${LOG_LEVEL:-"error"}

# Run Salt as daemon
exec /usr/bin/salt-minion --log-level=$LOG_LEVEL

exec mongod --fork --logpath /var/log/mongod/mongod.log
exec mongo --eval 'db.copyDatabase("mymongodb","mymongodb","10.240.20.20:27017","mongouser","p@$$w0rd","SCRAM-SHA-1")'
