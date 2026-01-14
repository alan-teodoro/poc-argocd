#!/bin/bash
set -e

echo "Creating Kind cluster for Redis Enterprise upgrade testing..."
kind create cluster --config kind-config.yaml

echo "Waiting for cluster to be ready..."
kubectl wait --for=condition=Ready nodes --all --timeout=300s

echo "Kind cluster created successfully!"
kubectl get nodes

