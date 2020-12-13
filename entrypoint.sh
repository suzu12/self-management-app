#!/bin/bash
set -e

rm -f /self-management-app/tmp/pids/server.pid

exec "$@"