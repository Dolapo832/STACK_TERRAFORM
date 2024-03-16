# module "STACK-TAGS" {
#   source="github.com/stackitgit/stackterraform.git?ref=stackmodules/STACK_TAGS"
#   #  source="./STACK_TAGS"
#   required_tags={
#     Environment=var.environment,
#     OwnerEmail=var.OwnerEmail,
#     System=var.subsystem,
#     Backup=var.backup,
#     Region=var.region
#   }
# }

### Declare Key Pair
### Declare Key Pair




# #creating my efs
# resource "aws_efs_file_system" "foo" {
#   creation_token = "my-efs"
#   tags = {
#     Name = "MyProduct"
#   }
# }

# #mounting the efs
# resource "aws_efs_mount_target" "alpha" {
#   file_system_id = aws_efs_file_system.foo.id
#   for_each   = var.subnets
#   subnet_id  = each.value
#   security_groups = [aws_security_group.stack-sg.id]
# }


# resource "aws_instance" "server" {
#   depends_on = [aws_efs_mount_target.alpha]
#   ami                     = data.aws_ami.stack_ami.id
#   instance_type           = var.instance_type
#   vpc_security_group_ids  = [aws_security_group.stack-sg.id]
#   user_data               = data.template_file.bootstrap.rendered
#   key_name                = aws_key_pair.Stack_KP.key_name
#   subnet_id               = var.subnet_id
#   security_groups         = [aws_security_group.stack-sg.id]
  
#  root_block_device {
#     volume_type           = "gp2"
#     volume_size           = 30
#     delete_on_termination = true
#     encrypted= "true"
#   }
#   tags = {
#    Name = "Application_Server_Aut1"
#    Environment = var.environment
#    OwnerEmail = var.OwnerEmail
# }
# }

# #load balancer
#  resource "aws_lb" "test" {
#   name               = "test-lb-tf"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups   = [aws_security_group.stack-sg.id]
#   subnets = [for s in data.aws_subnet.stack_sub : s.id]
   

#    enable_deletion_protection = false

#    tags = {
#          Environment = "Development"
#   }
#  }



#  resource "aws_launch_template" "stack_pre" {
#   name_prefix   = "stack_pre"
#   depends_on = [aws_efs_mount_target.alpha, aws_db_instance.CLIXX_DB]
#   image_id      = data.aws_ami.stack_ami.id
#   instance_type = var.instance_type
#   user_data = base64encode(data.template_file.bootstrap.rendered)
#   vpc_security_group_ids  = [aws_security_group.stack-sg.id]
#   # security_group_names = [aws_security_group.stack-sg.id]
# }


#   resource "aws_autoscaling_group" "app_asg" {
#   name             = "app_asg"
#   availability_zones = ["us-east-1a","us-east-1b"]
#   desired_capacity   = 2
#    max_size           = 4
#    min_size           = 2
  

#    launch_template {
#      id      = aws_launch_template.stack_pre.id
#      version = "$Latest"
    
#    }

#     tag {
#      key                 = "Environment"
#     value               = "App-server1"
#     propagate_at_launch = true
#   }

#   tag {
#     key                 = "Environment"
#     value               = "App-server2"
#     propagate_at_launch = true
#   }
#   target_group_arns         = [aws_lb_target_group.app_target_group.arn]
#   health_check_type         = "ELB"
#   health_check_grace_period = 300  

#   }
  
 

#  # Create a target group
#  resource "aws_lb_target_group" "app_target_group" {
#    name     = "app-target-group"
#    port     = 80
#    protocol = "HTTP"
#    vpc_id   = var.default_vpc_id   # Specify your VPC ID here
            
  

#     health_check {
#     path                = "/"
#      protocol            = "HTTP"
#      port                = 80
#      healthy_threshold   = 2
#      unhealthy_threshold = 2
#      timeout             = 3
#      interval            = 30
#    }
#  }

#  resource "aws_lb_listener" "example" {
#    load_balancer_arn = aws_lb.test.arn
#    port              = 80
#    protocol          = "HTTP"

#    default_action {
#      type             = "forward"
#      target_group_arn = aws_lb_target_group.app_target_group.arn
#    }
#  }

# resource "aws_db_instance" "CLIXX_DB" {
#   identifier             = "clixx"
#   instance_class         = "db.m6gd.large"
#   db_name                = ""
#   username               = "wordpressuser"
#   password               = "W3lcome123"
#   snapshot_identifier    = data.aws_db_snapshot.CLIXXSNAP.id
#   skip_final_snapshot    = true
#   vpc_security_group_ids = ["${aws_security_group.stack-sg.id}"]

#   lifecycle {
#     ignore_changes = [snapshot_identifier]
#   }
# }

##My blog deployment

#creating my efs
resource "aws_efs_file_system" "fool" {
  creation_token = "my-blog-efs"
  tags = {
    Name = "My-Blog "
  }
}

#mounting the efs
resource "aws_efs_mount_target" "alpha1" {
  file_system_id = aws_efs_file_system.fool.id
  for_each   = var.subnets
  subnet_id  = each.value
  security_groups = [aws_security_group.stack-sg.id]
}


resource "aws_instance" "server-blog" {
  depends_on = [aws_efs_mount_target.alpha1]
  ami                     = data.aws_ami.stack_ami.id
  instance_type           = var.instance_type
  vpc_security_group_ids  = [aws_security_group.stack-sg.id]
  #user_data               = data.template_file.blogbootstap.rendered
  key_name                = aws_key_pair.Stack_KP.key_name
  subnet_id               = var.subnet_id
  security_groups         = [aws_security_group.stack-sg.id]
  
 root_block_device {
    volume_type           = "gp2"
    volume_size           = 30
    delete_on_termination = true
    encrypted= "true"
  }
  tags = {
   Name = "Application_Server_blog"
   Environment = var.environment
   OwnerEmail = var.OwnerEmail
}
}

#load balancer
 resource "aws_lb" "test1" {
  name               = "test-blog-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups   = [aws_security_group.stack-sg.id]
  subnets = [for s in data.aws_subnet.stack_sub : s.id]
   

   enable_deletion_protection = false

   tags = {
         Environment = "Development"
  }
 }



 resource "aws_launch_template" "stack_blog" {
  name_prefix   = "stack_blog"
  depends_on = [aws_efs_mount_target.alpha1]
  image_id      = data.aws_ami.stack_ami.id
  instance_type = var.instance_type
  user_data = base64encode(data.template_file.blogbootstap.rendered)
  vpc_security_group_ids  = [aws_security_group.stack-sg.id]
  # security_group_names = [aws_security_group.stack-sg.id]
}


  resource "aws_autoscaling_group" "app_asg1" {
  name             = "app_asg1"
  availability_zones = ["us-east-1b"]
  desired_capacity   = 2
   max_size           = 4
   min_size           = 2
  

   launch_template {
     id      = aws_launch_template.stack_blog.id
     version = "$Latest"
    
   }

  target_group_arns         = [aws_lb_target_group.app_target_blog.arn]
  health_check_type         = "ELB"
  health_check_grace_period = 300  

  }
  
 

 #Create a target group
 resource "aws_lb_target_group" "app_target_blog" {
   name     = "app-target-blog"
   port     = 80
   protocol = "HTTP"
   vpc_id   = var.default_vpc_id   # Specify your VPC ID here
            
  

    health_check {
    path                = "/"
     protocol            = "HTTP"
     port                = 80
     healthy_threshold   = 2
     unhealthy_threshold = 2
     timeout             = 3
     interval            = 30
   }
 }

 resource "aws_lb_listener" "example-blog" {
   load_balancer_arn = aws_lb.test1.arn
   port              = 80
   protocol          = "HTTP"

   default_action {
     type             = "forward"
     target_group_arn = aws_lb_target_group.app_target_blog.arn
   }
 }


resource "aws_db_instance" "blog_DB" {
  identifier             = "wordpressinstance"
  instance_class         = "db.t3.micro"
  db_name                = ""
  username               = "admin"
  password               = "stackinc"
  snapshot_identifier    = data.aws_db_snapshot.BLOGSNAP.id
  skip_final_snapshot    = true
  vpc_security_group_ids = ["${aws_security_group.stack-sg.id}"]

  lifecycle {
    ignore_changes = [snapshot_identifier]
  }
}

resource "aws_ebs_volume" "my_volume" {
  count             = 3 
  availability_zone = aws_instance.server-blog.availability_zone
  size              = 20 # Size in GiB

  tags = {
    Name = "stack-Volumes"
  }
}

locals {
  device_names = ["/dev/sdf", "/dev/sdg", "/dev/sdh", "/dev/sdi", "/dev/sdj"] # Extend this list as needed
}

resource "aws_volume_attachment" "ebs_attachments" {
  count       = length(aws_ebs_volume.my_volume.*.id)

  device_name = element(local.device_names, count.index)
  volume_id   = aws_ebs_volume.my_volume[count.index].id
  instance_id = aws_instance.server-blog.id
  force_detach = true
}





