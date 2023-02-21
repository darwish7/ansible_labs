output "proxy-ips" {
  value = aws_instance.jump-host[*].id
}
