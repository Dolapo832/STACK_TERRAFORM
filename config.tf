# data "template_file" "bootstrap" {
#   template = file(format("%s/scripts/bootstrap.tpl", path.module))
#   vars={
#     GIT_REPO="https://github.com/stackitgit/CliXX_Retail_Repository.git"
#     MOUNT_POINT="/var/www/html"
#     efs= aws_efs_file_system.foo.dns_name
#     DB_USER="wordpressuser"
#     DB_PASS="W3lcome123"
#     DB_NAME="wordpressdb"
#     DB_HOST=aws_db_instance.CLIXX_DB.endpoint
#     CLIXX_LB= aws_lb.test.dns_name
#   }
# }

# data "aws_db_snapshot" "CLIXXSNAP" {
#   db_snapshot_identifier = "arn:aws:rds:us-east-1:381492048000:snapshot:wordpressdbclixx-snapshot"
#   most_recent            = true
# }

data "template_file" "blogbootstap" {
  template = file(format("%s/scripts/blogbootstap.tpl", path.module))
  vars={
    GIT_REPO1="https://github.com/Dolapo832/MY_STACK_BLOG.git"
    MOUNT_POINT1="/var/www/html"
    efs1= aws_efs_file_system.fool.dns_name
    DB_NAME1="wordpressdb"
    DB_USER1="admin"
    DB_PASSWORD="stackinc"
    RDS_INSTANCE=aws_db_instance.blog_DB.endpoint
    Blog_LB=aws_lb.test1.dns_name
  }
}

data "aws_db_snapshot" "BLOGSNAP" {
  db_snapshot_identifier = "arn:aws:rds:us-east-1:381492048000:snapshot:wordpressinstance-snapshot"
  most_recent            = true
}

