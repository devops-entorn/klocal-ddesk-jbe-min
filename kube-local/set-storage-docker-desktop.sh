#!/bin/bash

#kubectl --namespace entorn apply -f pvc-dockerdata-claim.yaml
kubectl --namespace entorn apply -f pvc-apps-claim.yaml
#kubectl --namespace entorn apply -f pvc-dbdata-claim.yaml
kubectl --namespace entorn apply -f pvc-exchange-claim.yaml
kubectl --namespace entorn apply -f pvc-conda-envs-claim.yaml 
