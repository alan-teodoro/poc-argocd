# Redis Enterprise Upgrade Testing with ArgoCD

Test Redis Enterprise upgrades using ArgoCD and Helm in a local Kind cluster.

## Overview

- **Initial Version**: Redis Enterprise 7.22.0-17
- **Target Version**: Redis Enterprise 7.22.2-31
- **Orchestration**: ArgoCD (GitOps)
- **Local Testing**: Kind cluster

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Kind](https://kind.sigs.k8s.io/docs/user/quick-start/#installation)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)

## Quick Start

### 1. Create Kind Cluster

```bash
./scripts/01-create-cluster.sh
```

### 2. Install ArgoCD

```bash
./scripts/02-install-argocd.sh
```

**Access ArgoCD UI:**
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
# Open: https://localhost:8080
# User: admin
# Password: (shown by install script)
```

### 3. Deploy Redis via ArgoCD

```bash
kubectl apply -f argocd/bootstrap/root-app.yaml
```

ArgoCD will automatically deploy:
- Redis Enterprise Operator (7.22.0-17)
- Database Secret
- Redis Enterprise Cluster (3 nodes)
- Redis Database (db1)

**Monitor:**
```bash
./scripts/check-status.sh
```

### 4. Cleanup

```bash
./scripts/99-cleanup.sh
```

## How It Works

ArgoCD manages everything using the **App of Apps** pattern:

1. You apply ONE manifest: `argocd/bootstrap/root-app.yaml`
2. ArgoCD reads `argocd/apps/` directory
3. ArgoCD creates all child applications
4. ArgoCD deploys in order (sync waves):
   - Wave 1: Operator + Secrets
   - Wave 2: Cluster
   - Wave 3: Databases

## Upgrade Process

Edit `argocd/apps/redis-operator.yaml` and change version:
```yaml
targetRevision: 7.22.2-31  # Change from 7.22.0-17
```

Commit and push. ArgoCD will sync automatically.

## References

- [Redis Enterprise Operator](https://docs.redis.com/latest/kubernetes/)
- [ArgoCD Documentation](https://argo-cd.readthedocs.io/)
- [Kind Documentation](https://kind.sigs.k8s.io/)
