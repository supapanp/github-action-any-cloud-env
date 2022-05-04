### Create the EC2(s): Multiple EC2 Node
resource "aws_instance" "ec2_az3" {
  count                  = var.instances_per_az
  ami                    = lookup(var.ami, var.server_type)
  instance_type          = lookup(var.instance_type, var.instance_size)
  availability_zone      = var.az3
  monitoring             = var.instance_monitor
  key_name               = "${var.vpc_name}-keypair"
  subnet_id              = var.subnet_public_1c
  vpc_security_group_ids = [aws_security_group.instance_secgroup.id]

  user_data = <<-EOF
                              #!/bin/bash
                              curl https://raw.githubusercontent.com/praparn/sourcesetup/master/standard_host.sh > /tmp/setup.sh
                              chmod +x /tmp/setup.sh
                              /tmp/setup.sh
                              EOF

  associate_public_ip_address = var.associate_public_ip_address
  root_block_device {
    volume_type           = var.volume_type_std
    volume_size           = var.volume_size_boot_std
    delete_on_termination = var.delete_on_termination
  }

  tags = {
      Name = "${var.instance_prefixname}-az3-${count.index+1}"
      Environment = var.tag_environment
      Region      = var.tag_region
      Budget      = var.tag_budget
      Categories  = var.tag_category
  }
}