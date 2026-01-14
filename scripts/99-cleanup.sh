#!/bin/bash
set -e

echo "Deleting Kind cluster..."
kind delete cluster --name redis-upgrade-test

echo "Cluster deleted successfully!"

