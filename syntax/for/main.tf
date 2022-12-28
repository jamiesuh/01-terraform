provider "local" {
}

variable "user_names" {
  description = "Names to render"
  type        = list(string)
  default = [ "aws13-neo", "aws13-trinity", "aws13-morpheus" ]
}

output "for_directive" {
	value = <<EOF
		%{~for name in var.user_names}
		${name}
		%{~endfor} 
	EOF
}
