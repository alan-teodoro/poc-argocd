#!/bin/bash

echo "========================================="
echo "Redis Enterprise Cluster Status"
echo "========================================="
echo ""

echo "ArgoCD Applications:"
kubectl get applications -n argocd
echo ""

echo "Redis Operator:"
kubectl get deployment redis-enterprise-operator -n redis
echo ""

echo "Redis Enterprise Cluster:"
kubectl get rec -n redis
echo ""

echo "Redis Databases:"
kubectl get redb -n redis
echo ""

echo "Redis Pods:"
kubectl get pods -n redis
echo ""

echo "Redis Services:"
kubectl get svc -n redis
echo ""

echo "========================================="
echo "Detailed Status"
echo "========================================="
echo ""

echo "Redis Cluster Details:"
kubectl describe rec rec -n redis | grep -A 10 "Status:"
echo ""

echo "Database db1 Status:"
kubectl get redb db1 -n redis -o jsonpath='{.status.status}' 2>/dev/null && echo "" || echo "Not found or not ready"
echo ""

echo "Database db2 Status:"
kubectl get redb db2 -n redis -o jsonpath='{.status.status}' 2>/dev/null && echo "" || echo "Not found or not ready"
echo ""

echo "========================================="
echo "Current Versions"
echo "========================================="
echo ""

echo "Operator Version:"
kubectl get deployment redis-enterprise-operator -n redis -o jsonpath='{.spec.template.spec.containers[0].image}'
echo ""
echo ""

echo "Cluster Version:"
kubectl get rec rec -n redis -o jsonpath='{.spec.redisEnterpriseImageSpec.imagePullPolicy}' 2>/dev/null && \
kubectl get rec rec -n redis -o jsonpath='{.status.version}' 2>/dev/null && echo "" || echo "Not available"
echo ""

