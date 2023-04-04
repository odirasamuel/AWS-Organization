variable "alias" {
  description = "Alias for the account"
  type = string
  default = ""
}

variable "tags" {
  description = "Tags for the user"
  type = map(string)
  default = {}
}

variable "primaryDetectorId" {
  description = "This is the primary organizational account detector id"
}

variable "guardDutyEmail" {
  description = "This is the email address to which the invite will be sent"
}