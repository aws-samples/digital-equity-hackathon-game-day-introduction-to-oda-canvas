output "configure_kubectl" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = "aws eks --region ${local.region} update-kubeconfig --name ${module.eks.cluster_name}"
}

output "grafana_secret_name" {
  description = "Grafana password secret name"
  value       = aws_secretsmanager_secret.grafana.name
}

output "api_gatewayv2_vpc_link_id" {
  description = "API Gateway v2 VPC link ID"
  value       = resource.aws_apigatewayv2_vpc_link.vpc_link.id
}
