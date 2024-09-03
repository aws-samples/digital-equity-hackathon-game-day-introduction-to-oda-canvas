# Amazon EKS Cluster using AWS Blueprints Addons for ODA Canvas

This example shows how to provision an Amazon EKS cluster using [AWS Blueprints Addons](https://aws-ia.github.io/terraform-aws-eks-blueprints-addons/main/) with all the prerequisites for ODA Canvas Framework.

* Deploy EKS Cluster with one managed node group in an VPC
* Install AWS Controllers for Kubernetes (ACK) for API Gateway v2 and Amazon RDS, Metrics Server, Kube-Prometheus-Stack and EKS Managed Addons (vpc-cni, kube-proxy, coredns, aws-ebs-csi-driver) using the Blueprints. 
* The deployment will create also a workspace for Amazon Managed Prometheus where metrics can be exported.
* Install Istio using Helm resources in Terraform
* Install Istio Ingress Gateway using Helm resources in Terraform
  * This step deploys a Service of type `LoadBalancer` that creates an AWS Network Load Balancer.
* Install ODA Canvas Framework using Helm resources in Terraform

## Deploy

See [here](https://aws-ia.github.io/terraform-aws-eks-blueprints/getting-started/#prerequisites) for the prerequisites and run the following command to deploy this pattern.

```sh
git clone https://github.com/ovaleanu/eks-oda-canvas-tf.git
cd eks-oda-canvas-tf
./install.sh
```

Once the resources have been provisioned, you will need to replace the `istio-ingress` pods due to a [`istiod` dependency issue](https://github.com/istio/istio/issues/35789). Use the following command to perform a rolling restart of the `istio-ingress` pods:

```sh
kubectl rollout restart deployment istio-ingress -n istio-ingress
```

### Optional: Observability Add-ons for Istio

Use the following code snippet to add the Istio Observability Add-ons on the EKS cluster with deployed Istio.

```sh
for ADDON in kiali jaeger
do
    ADDON_URL="https://raw.githubusercontent.com/istio/istio/release-1.20/samples/addons/$ADDON.yaml"
    kubectl apply -f $ADDON_URL
done
```

## Install ODA Canvas

Add oda-canvas helm repo

```sh
helm repo add oda-canvas https://tmforum-oda.github.io/oda-canvas
helm repo update
```

Install the canvas using the following command

```sh
helm install canvas oda-canvas/canvas-oda -n canvas --create-namespace
```
