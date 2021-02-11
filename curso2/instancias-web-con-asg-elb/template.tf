data "template_file" "user_data" {
  template = file("user-data.txt")
  vars = {
    project_name = var.project_name
  }
}
