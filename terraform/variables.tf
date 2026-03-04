variable "IBM_IAM_API_KEY" {
  sensitive   = true
  description = "The IBM Cloud IAM API key to use for the IBM Cloud provider."
}


variable "git_sha" {
  description = "The git sha of the current commit"
}
