#!/usr/bin/env nu

rm --force .env

source scripts/kubernetes.nu
source scripts/ingress.nu
source scripts/cnpg.nu

create_kubernetes kind

let ingress_data = apply_ingress kind nginx

create_cnpg

(
    helm upgrade --install kro oci://public.ecr.aws/kro/kro
        --namespace kro --create-namespace
)

kubectl create namespace a-team