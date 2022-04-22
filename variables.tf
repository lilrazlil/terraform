
variable "man_org" {
  type        = string
  description = "Name manage organization"
  default = "rombabomba"
}

variable "list_admins" {
  type = list
  description = "People who add in membership organization"
  default =  ["lilrazlil","AChechnev-Ostvald"]
}

variable "main_repos" {
  type = list
  description = "Original repos"
  default = ["frontend","backend","smart-contract"]
}

variable "environment" {
  default="MAIN"
}