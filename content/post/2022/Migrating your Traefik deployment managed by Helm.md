# Introduction
Here, I'll explain you how to upgrade your Traefik version sitting on a Kubernetes cluster (version 1.23.1) on AWS.

In my case, I was moving from Traefik 2.1 to 2.5, but this could be more or less translated between other versions.

> Note: This is the way I performed the migration of Traefik and there are other ways to do it so YMML.

# Steps overview

1.  Check 2.4 and 2.5 releases for breaking changes

Reference: [https://doc.traefik.io/traefik/migration/v2/#v23-to-v24](https://doc.traefik.io/traefik/migration/v2/#v23-to-v24)
Reference: [https://doc.traefik.io/traefik/migration/v2/#v24-to-v25](https://doc.traefik.io/traefik/v2.4/migration/v2/#v23-to-v24)

2. Check helm chart releases for breaking changes
3. Fix your custom values for all your deployment
4. Apply CRDs (Remember Helm doesn't manage CRDs)
5. Deploy a new release of Traefik with Helm (installing the final Traefik version that we want to move)
6. Perform your DNS changes pointing to the new ELB (External Load Balancer)
7. Check your monitoring for new traffic
8. When you feel comfortable, delete the previous release!