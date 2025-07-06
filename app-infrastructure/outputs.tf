
output "alb_dns_name" {
  value = aws_lb.app.dns_name
}

output "user_service_path" {
  value = "${aws_lb.app.dns_name}/hi"
}
