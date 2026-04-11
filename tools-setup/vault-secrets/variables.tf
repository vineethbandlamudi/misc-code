variable "secrets" {
  default = {
    roboshop-dev = {
      description = "Roboshop App components Secrets"
    }
  }
}

variable "values" {
  default = {
    cart = {
      secret = "roboshop-dev"
      value = {
        zip = "zap"
      }
    }
  }
}