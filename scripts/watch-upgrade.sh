#!/bin/bash

echo "========================================="
echo "Monitoring Redis Enterprise Upgrade"
echo "========================================="
echo ""

echo "Press Ctrl+C to stop monitoring"
echo ""

while true; do
    clear
    echo "========================================="
    echo "Redis Enterprise Upgrade Monitor"
    echo "Time: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "========================================="
    echo ""
    
    echo "📦 OPERATOR VERSION:"
    kubectl get deployment redis-enterprise-operator -n redis -o jsonpath='{.spec.template.spec.containers[0].image}' 2>/dev/null || echo "N/A"
    echo ""
    echo ""
    
    echo "🔧 CLUSTER STATUS:"
    kubectl get rec rec -n redis -o custom-columns=NAME:.metadata.name,STATE:.status.state,VERSION:.status.version 2>/dev/null || echo "No cluster found"
    echo ""
    
    echo "⚙️  JOBS (Installer):"
    kubectl get jobs -n redis 2>/dev/null || echo "No jobs running"
    echo ""
    
    echo "📊 PODS:"
    kubectl get pods -n redis -o wide 2>/dev/null || echo "No pods found"
    echo ""
    
    echo "🔄 ARGOCD SYNC STATUS:"
    kubectl get application redis-operator -n argocd -o custom-columns=NAME:.metadata.name,SYNC:.status.sync.status,HEALTH:.status.health.status,VERSION:.status.sync.revision 2>/dev/null || echo "N/A"
    echo ""
    
    echo "========================================="
    echo "Refreshing in 5 seconds... (Ctrl+C to stop)"
    echo "========================================="
    
    sleep 5
done

