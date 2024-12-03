locals {
  json_files_map = { for i, file in var.json_files_list : i =>  file }
  printed_map    = jsonencode(local.json_files_map)
}