// How to use Terraform Count Index Meta-Argument? (with Examples)

// 1.Count:
// In Terraform a resource block is used to create only one infrastructure component (e.g., a virtual machine like an AWS EC2 instance). But what if you need multiple similar infrastructure components (e.g., multiple virtual machines, like a pool of AWS EC2 instances)? Do you need to write out individual resource blocks to create several similar infrastructure objects?
// Well, you don’t need to! Terraform has a count meta-argument to help you configure several similar infrastructure objects. Let’s explore what the count meta-argument is and the challenges it comes with. We’ll also discuss how the count.index attribute enables us to reference the current resource instance.
// Key Takeaways
// •	It is recommended to use the count meta-argument to provision multiple similar infrastructure objects that are almost identical.
// •	The count meta-argument can be used in resource, data, or module blocks.
// •	The count and for_each meta-arguments cannot be used in the same block, as both are used to create multiple similar infrastructure objects.
// What are meta-arguments in Terraform?
// To understand what a count meta-argument is used for, let’s start by understanding what meta-arguments are in Terraform. Meta-arguments are special arguments provided by Terraform to be used in the resource, data, or module blocks. The meta-argument supported in each block type varies. For example, the count meta-argument is supported in the resource, data, and module blocks.
// Want to learn more about Terraform's resource, data, or module blocks? Check out this video:
// The count meta-argument is one of the 2 ways to create multiple instances of an infrastructure resource. The other way is to use the for_each meta_argument. It is commonly used when your instances have some arguments with distinct values.
// What is the count meta-argument?
// The count meta-argument accepts a whole number. It is used to create multiple instances of an infrastructure object when it is used in a resource or module block. Also, when used in a data block, it fetches multiple instances of an object. Let’s look at some examples that use the count meta-argument.
// count meta-argument examples
// As mentioned earlier, the count meta-argument can be used in the resource, data, or module blocks. The examples below demonstrate its usage.
// Using count in resource blocks
// Let’s start with a simple example below:
// # variables.tf
// variable "ami" {
//   type    = string
//   default = "ami-0078ef784b6fa1ba4"
// }

// variable "instance_type" {
//   type    = string
//   default = "t2.micro"
// }

// # main.tf
// resource "aws_instance" "sandbox" {
//   count         = 3
//   ami           = var.ami
//   instance_type = var.instance_type
//   tags = {
//     Name = "sandbox_server"
//   }
// }
// In the code above, 3 AWS EC2 instances (i.e., 3 aws_instance.sandbox infrastructure objects) are provisioned using the count meta-argument. But the issue here is that all EC2 instances will be tagged with the same name (i.e., sandbox_server), which is not what we want.
// This is where the count object attribute (i.e., count.index) comes into play. The count.index attribute represents the unique index number of each object created using the count meta-argument. Let’s see how it can be used below:
// # variables.tf
// variable "ami" {
//   type    = string
//   default = "ami-0078ef784b6fa1ba4"
// }

// variable "instance_type" {
//   type    = string
//   default = "t2.micro"
// }

// variable "sandboxes" {
//   type    = list(string)
//   default = ["sandbox_server_one", "sandbox_server_two", "sandbox_server_three"]
// }

// # main.tf
// resource "aws_instance" "sandbox" {
//   ami           = var.ami
//   instance_type = var.instance_type
//   count         = 3
//   tags = {
//     Name = var.sandboxes[count.index]
//   }
// }
// In the code above, var.sandboxes is a list of strings that represents server names. The count.index attribute represents the current index number of the infrastructure object (i.e., aws_instance.sandbox) being created.
// The count.index attribute starts at 0 for the 1st resource instance, then in the next iteration, it is 1 for the 2nd resource instance, and for the last iteration (i.e., since the count is 3), it is index number 2.
// Using the count.index like above, is still fragile because each instance is still identified by Terraform using its index and not the string value in the list. For example, the 1st instance will still be referenced as aws_instance.sandbox[0]. This will be discussed further in the “Referencing blocks and block instances” section later in this article.
// The count meta-argument also accepts numeric expressions. Let’s see an example below:
// # variables.tf
// variable "ami" {
//   type    = string
//   default = "ami-0078ef784b6fa1ba4"
// }

// variable "instance_type" {
//   type    = string
//   default = "t2.micro"
// }

// variable "sandboxes" {
//   type    = list(string)
//   default = ["sandbox_server_one", "sandbox_server_two", "sandbox_server_three"]
// }

// # main.tf
// resource "aws_instance" "sandbox" {
//   ami           = var.ami
//   instance_type = var.instance_type
//   count         = length(var.sandboxes)
//   tags = {
//     Name = var.sandboxes[count.index]
//   }
// }
// In the code above, the length function determines the length of the given list (i.e., var.sandboxes). The expression length(var.sandboxes) evaluates to 3, which is used by the count meta-argument to create 3 resource instances.
// Using count in data blocks
// The count meta-argument can also be used inside data blocks. Let’s see an example below:
// # variables.tf
// variable "sandboxes" {
//   type    = list(string)
//   default = ["sandbox_server_one", "sandbox_server_two", "sandbox_server_three"]
// }

// # main.tf
// data "aws_instances" "sandbox_server" {
//   count = 2

//   filter {
//     name   = "tag:Name"
//     values = var.sandboxes
//   }

//   filter {
//     name   = "instance-state-name"
//     values = ["running"]
//   }
// }
// In the code above, the count meta-argument in the data block is used to fetch only 2 AWS EC2 instances that match the given requirements specified in the nested filter blocks.
// Using count in module blocks
// The count meta-argument can also be used inside module blocks. Let’s see an example below:
// # child module - variables.tf
// variable "ami" {
//   type    = string
//   default = "ami-0078ef784b6fa1ba4"
// }

// variable "instance_type" {
//   type    = string
//   default = "t2.small"
// }

// variable "nameTag" {
//   type    = string
//   default = "testTag"
// }

// # child module - web_server.tf
// resource "aws_instance" "sandbox" {
//   ami           = var.ami
//   instance_type = var.instance_type
//   tags = {
//     Name = var.nameTag
//   }
// }

// # root module - variables.tf
// variable "sandboxes" {
//   type    = list(string)
//   default = ["sandbox_server_one", "sandbox_server_two", "sandbox_server_three"]
// }

// # root module - main.tf
// module "web_servers" {
//   source = "./modules/web_servers"

//   count         = 3
//   instance_type = "t2.micro"
//   nameTag       = var.sandboxes[count.index]
// }
// Terraform Modules are commonly used to hide implementation details of infrastructure objects to be provisioned. You can reuse infrastructure objects by organizing these resources into small and manageable components. A module is just a directory with Terraform configuration files. A root (i.e., parent module) module is a module that calls the child module.
// In the example above, the web_servers module is reused to create multiple web server instances using the count meta-argument.
// Please note that the example above uses a local Terraform module. You can also use modules in Terraform’s public registry.
// Key considerations when working with the count meta-argument
// We have seen several examples of how the count meta-argument can be used. Below are some things to keep in mind when working with it.
// Referencing blocks and block instances
// Blocks that use the count meta-argument (i.e., resource, data, and module blocks) create multiple infrastructure instances. So, how does Terraform refer to each of these instances and also the block itself? Let’s see how.
// Referring to the block: use <block_type>.<block_name>. Below are examples of references for block types.
// •	Resource block: <resource_type>.<resource_name> e.g. aws_instance.sandbox_server
// •	Data block: data.<resource_type>.<resource_name> e.g. data.aws_instances.sandbox_server
// •	Module block: module.<module_name> e.g. module.web_servers
// Referring to the instance: use <block_type>.<block_name>[<index>]. Below are examples of references for instances that use count
// •	Resource block: <resource_type>.<resource_name>[<index>] e.g. aws_instance.sandbox_server[0]. Also, to reference another resource block attribute, you can use <resource_type>.<resource_name>[count.index].attribute e.g aws_instance.sandbox[count.index].arn
// •	Data block: data.<resource_type>.<resource_name>[<index>] e.g. data.aws_instances.sandbox_server[0]
// •	Module block: module.<module_name>[<index>] e.g. module.web_servers[0]
// For a module that creates multiple instances of a specified resource, the instances are prefixed with the module.<module_name>[<index>] in the Terraform UI. Below are trimmed-down versions of the terraform plan output for the module used in the “Using count in module blocks” section:
   
// Expressions with count
// As mentioned earlier, the count meta-argument can accept numeric expressions. These numeric expressions must be known before Terraform applies any configuration. We saw an example in the “Using count in resource block” section with the length function, which evaluated to a numeric value.
// A numeric expression could also be a conditional expression that evaluates to a number. Let’s see an example below:
// # variables.tf
// variable "ami" {
//   type    = string
//   default = "ami-0078ef784b6fa1ba4"
// }

// variable "instance_type" {
//   type = string
//   default = "t2.small"
// }

// # main.tf
// resource "aws_instance" "dev" {
//   ami           = var.ami
//   instance_type = var.instance_type
//   count         = var.instance_type == "t2.micro" ? 1 : 0
//   tags = {
//     Name = "dev_server"
//   }
// }
// From the code above, in the expression var.instance_type == “t2.micro” ? 1 : 0, if the instance_type is not t2.micro, it will evaluate to 0, and no instance will be created.
// Limitations with count
// Even if the count meta-argument is used to provision multiple infrastructure objects in Terraform; it is recommended to use it when provisioning objects that are almost identical to avoid unexpected infrastructural changes during a modification.
// In the example where count is used with a numeric expression in the “Using count in resource block” section, it might be better to use for_each instead.
// This is because, with count, if you remove the element at index 0 (i.e., sandbox_server_one) in var.sandboxes, the following happens:
// •	The current element at index 1 (i.e., sanbox_server_two) will now become the new element at index 0, i.e., sandbox_server_two is now at index 0
// •	The current element at index 2 (i.e., sanbox_server_three) will now be the new element at index 1, i.e., sandbox_server_three is now at index 1
// •	There will be no element at index 3, and this index will be destroyed
// If you are not bothered about these unintended changes, then count could be a good meta-argument to use in this scenario.
// Performance considerations when using count
// Below are some best practices to adhere to when working with count:
// •	Using count potentially increases the number of API requests made to a Terraform provider for every infrastructure object created. Hence, you need to use count carefully to avoid exceeding API rate limits which can degrade performance.
// •	Use count cautiously in data blocks. When you fetch data in large-scale deployments using the data block with the count meta-argument, the result could be quite large. If this happens and the underlying server that Terraform runs on has limited resources (i.e., memory, CPU), it can impact Terraform’s process, which eventually impacts performance.
// Test your Terraform mastery with our free Terraform Challenges. They will help in polishing your infrastructure provisioning and management skills!
// FAQ
// Below are some of the frequently asked questions about the count meta-argument.
// When should I use count instead of for_each?
// If your resource instances are identical and not impacted by the unintended changes that count causes during modification, then you can use the count meta-argument.
// For_each is commonly used when you need to create similar infrastructure objects that have distinct values for their arguments. Also, if you do not want the unexpected changes that come with using count when modifying your infrastructure object.
// Can you use both count and for_each meta-arguments in the same block?
// You cannot use both in the same resource block because they serve a similar purpose. They both create multiple instances of a resource.
// Conclusion
// You have learned why Terraform introduced count and can decide when to use the count or for_each meta-argument. Even though count helps you create multiple similar resource instances, you need to know if it is the right meta-argument for your use case. If your infrastructure objects need distinct values that can’t be derived from a whole number, then it’s recommended to use for_each.


// For_each

// Terraform for_each: A simple Explanation  with Examples
// Congratulations! You recently joined an SRE team that uses Terraform to provision and manage infrastructure components. After some time, you notice that they configured a couple of similar infrastructure resources using the count meta-argument as seen in the code snippet below:
// # variables.tf
// variable "ami" {
//   type    = string
//   default = "ami-0078ef784b6fa1ba4"
// }

// variable "instance_type" {
//   type    = string
//   default = "t2.micro"
// }

// variable "sandboxes" {
//   type    = list(string)
//   default = ["sandbox_one", "sandbox_two", "sandbox_three"]
// }

// # main.tf
// resource "aws_instance" "sandbox" {
//   ami           = var.ami
//   instance_type = var.instance_type
//   count         = length(var.sandboxes) 
//   tags = {
//     Name = var.sandboxes[count.index]
//   }
// }
// After going through the existing terraform configuration files, you identified some inefficient code and proposed some code changes. The first batch of this code refactor includes using the for_each instead of the count meta-argument.
// But what issues does the count meta-argument really pose since it achieved the desired end result? Why was the for_each meta-argument introduced by Terraform? Let’s first understand what meta-arguments are in Terraform, then dive into why for_each exists.
// Key Takeaways
// •	for_each is commonly used to provision multiple similar infrastructure resources in Terraform. It prevents unintended remote object changes that come with using the count meta-argument.
// •	The for_each meta-argument can be used in resource, data, or module blocks. Also, when working with for_each in these blocks, there are some important rules to follow e.g., for_each only accept values that are sets or maps.
// •	The for_each and count meta-arguments cannot be used in the same block, as both are used to create multiple similar infrastructure objects in Terraform.
// What are Meta-arguments in Terraform?
// Meta-arguments are simply terraform’s special arguments used in the resource, data, or module blocks to customize the behavior of these blocks. Each of these block types has its set of meta-arguments that it supports. For example, the resource block in Terraform supports the count meta-argument, as seen earlier above. It also supports the for_each meta-argument and some others.
// Want to learn more about Terraform's basic concepts? Check out this video:
// By default, a resource block in Terraform creates only one infrastructure resource, which could be a storage bucket, load balancer, compute instance, virtual network, etc.
// But what if you want to provision more than one infrastructure resource of the same resource type? This is where meta-arguments like count and for_each come in. They are the two ways of creating multiple instances of an infrastructure resource in Terraform. For example, instead of typing an individual resource block for every instance of an infrastructure resource you want to create, you can instead type a single resource block and then use a meta-argument like count or for_each to create multiple instances of any infrastructure resource as desired.
// Using the count meta-argument in certain ways, like it was done above, is not recommended. Let’s see why in the next section.
// The Problem with the Count Meta-argument
// Lists are ordered collections which means that the order of every element within a list is significant. The count meta_argument works with a list type, meaning every element has an index position - as seen below - when you run the terraform state list command to list all resources in the terraform.tfstate file:
// aws_instance.sandbox[0]
// aws_instance.sandbox[1]
// aws_instance.sandbox[2]
// From above, every element is referenced using an index number, and not even the string values in the sandboxes variable in the code snippet seen earlier, i.e., default = ["sandbox_one", "sandbox_two", "sandbox_three"]. If you remove any element that is not the last element in the list above, you would get unexpected infrastructure resource changes when you run terraform plan to see the execution plan.
// For example, if you remove the element at index 0 (i.e., sandbox_one), the following happens:
// •	The current element at index 1 (i.e., sanbox_two) will now become the new element at index 0, i.e., sandbox_two is now at index 0
// •	The current element at index 2 (i.e., sanbox_three) will now be the new element at index 1, i.e., sandbox_three is now at index 1
// •	There will be no element at index 3, and this index will be destroyed
// This is where the flexibility of the for_each meta-argument comes into play. Since for_each works with unordered collections like a map or set, elements are instead referenced by string values. Let’s dive deeper into the for_each meta-argument in the following sections.
// The for_each meta-argument
// The for_each meta-argument is just another way to create multiple similar instances of an infrastructure resource in a more flexible way. It can be used in a resource, data, or module block. It works with a map or a set of strings, and it creates an instance for each item in a map or set. Let’s look at some examples of how for_each is used below.
// Examples using the for_each meta-argument
// As mentioned earlier, for_each can be used in the resource, data, or module blocks. The examples below demonstrate its usage:
// Using for_each in resource blocks
// Let’s start by refactoring the code snippet with the count meta-argument that we saw earlier:
// # variables.tf
// variable "ami" {
//   type    = string
//   default = "ami-0078ef784b6fa1ba4"
// }

// variable "instance_type" {
//   type    = string
//   default = "t2.micro"
// }

// variable "sandboxes" {
//   type    = list(string)
//   default = ["sandbox_one", "sandbox_two", "sandbox_three"]
// }

// # main.tf
// resource "aws_instance" "sandbox" {
//   ami           = var.ami
//   instance_type = var.instance_type
//   for_each      = toset(var.sandboxes)
//   tags = {
//     Name = each.value # for a set, each.value and each.key is the same
//   }
// }
// Since for_each works with either a set or map of strings, we can just do a type conversion using the built-in terraform function, toset. It takes a list type and converts it to a set. A set is an unordered collection of unique values.
// The for_each meta-argument used in any block type also comes with the each object available. The each object is used to customize the configuration of each similar resource. This object also comes with 2 properties:
// •	each.key for a set is the values of a set. For a map, it is the map’s key, e.g. {map_key: “map_value” }
// •	each.value for a set is the same as each.key. For a map, it is the associated value for the key.
// In the code above, for the first iteration, each.value will be sandbox_one, for the next iteration, it will be sandbox_two, and then sandbox_three. It will create 3 AWS EC2 instances tagged with the names sandbox_one, sandbox_two, and sandbox_three.
// We can use Terraform set type to refactor it further, as seen below:
// # variables.tf
// variable "ami" {
//   type    = string
//   default = "ami-0078ef784b6fa1ba4"
// }

// variable "instance_type" {
//   type    = string
//   default = "t2.micro"
// }

// variable "sandboxes" {
//   type    = set(string)
//   default = ["sandbox_one", "sandbox_two", "sandbox_three"]
// }

// # main.tf
// resource "aws_instance" "sandbox" {
//   ami           = var.ami
//   instance_type = var.instance_type
//   for_each      = var.sandboxes
//   tags = {
//     Name = each.value # for a set, each.value and each.key is the same
//   }
// }
// As you can see above, since the variable sandboxes is now a set type, there is no need for type conversion. Also, note that each instance created by for_each is a map of objects.
// Now, let’s see another example that uses the map type:
// # variables.tf
// variable "ami" {
//   type    = string
//   default = "ami-0078ef784b6fa1ba4"
// }

// variable "sandboxes" {
//   type = map(object({
//     instance_type = string,
//     tags          = map(string)
//   }))
//   default = {
//     sandbox_one = {
//       instance_type = "t2.small"
//       tags = {
//         Name = "sandbox_one"
//       }
//     },
//     sandbox_two = {
//       instance_type = "t2.micro"
//       tags = {
//         Name = "sandbox_two"
//       }
//     },
//     sandbox_three = {
//       instance_type = "t2.nano"
//       tags = {
//         Name = "sandbox_three"
//       }
//     }
//   }
// }

// # main.tf
// resource "aws_instance" "sandbox" {
//   ami           = var.ami
//   for_each      = var.sandboxes
//   instance_type = each.value["instance_type"]
//   tags          = each.value["tags"]
// }
// A map type in Terraform is a type constructor, which allows you to build up complex types. It is of the form map(<TYPE>), where TYPE can be a type constraint like a string or even a type constructor like an object. The above example uses a map of objects to create multiple AWS EC2 instances.
// Each instance (i.e., sanbox_one, sandbox_two, and sandbox_three) above consists of a string and a map of string as values in the map seen above. The object, each.value, in the resource block references the map keys, i.e., instance_type and tags.
// The resource block can also be written as:
// # main.tf
// resource "aws_instance" "sandbox" {
//   ami           = var.ami
//   for_each      = var.sandboxes
//   instance_type = each.value.instance_type
//   tags          = each.value.tags
// } 
// It is just another way to reference the map keys using the dot notation.
// Please note that the arguments used in any resource block vary based on the provider. AWS is the provider used in the examples above.
// Using for_each in data blocks
// Let’s see an example of how for_each is used in a data block:
// # variables.tf
// variable "instance_ids" {
//   type    = set(string)
//   default = ["i-0c394b14ded6e401f", "i-02a4984badba201cb", "i-0c791c2e2e0f6f0b3"]
// }
// variable "drive_size" {
//   type    = number
//   default = 6
// }

// # main.tf
// data "aws_instance" "test_server" {
//   for_each    = var.instance_ids
//   instance_id = each.value
//   filter {
//     name   = "tag:Environment"
//     values = ["test"]
//   }
//   filter {
//     name   = "instance-state-name"
//     values = ["running"]
//   }
// }

// resource "aws_ebs_volume" "test_server_drive" {
//   for_each          = data.aws_instance.test_server
//   availability_zone = data.aws_instance.test_server[each.key].availability_zone
//   size              = var.drive_size
// }

// resource "aws_volume_attachment" "test_server_drive_attach" {
//   for_each    = data.aws_instance.test_server
//   device_name = "/dev/sdb"
//   volume_id   = aws_ebs_volume.test_server_drive[each.key].id
//   instance_id = data.aws_instance.test_server[each.key].id
// }
// In the code above, the data block (i.e. aws_instance.test_server) fetches information about AWS EC2 instances based on the specified requirements (i.e. instance_id, tag, and the instance state). Using for_each, it fetches all EC2 instances that have the specified instance id in the instance_ids set variable. Also, the instances fetched should have the Environment:test tag, and they should all be in a running state.
// Then, in the resource block (i.e., aws_ebs_volume.test_server_drive), the data source (i.e., aws_instance.test_server) is referenced in the for_each expression. In Terraform, resources using for_each are represented as a map of objects. So, data.aws_instance.test_server is actually a map of objects, where each object is an instance fetched by the data block. Hence, data.aws_instance.test_server is represented as:
// {
//     test_server_1 = {
//       id                = "i-0c394b14ded6e401f"
//       availability_zone = "ca-central-1"
//       // other data resource attributes
//     },
//     test_server_2 = {
//       id                = "i-02a4984badba201cb"
//       availability_zone = "ca-central-1"
//       // other data resource attributes
//     },
//     test_server_3 = {
//       instance_type     = "i-0c791c2e2e0f6f0b3"
//       availability_zone = "ca-central-1"
//       // other data resource attributes
//     }
// }
// So, an aws_ebs_volume.test_server_drive volume resource is created for every data.aws_instance.test_server instance fetched. In the same vein, data.aws_instance.test_server[each.key].availability_zone gets the availability zone for each EC2 instance fetched by the data source block. Since data.aws_instance.test_server is a map of objects, each.key refers to the map key (e.g., test_server_1), and you can now get any attribute of the instance using the dot notation (e.g., .availability_zone).
// The same concept also applies in the aws_volume_attachment.test_server_drive_attach resource block above. For each EC2 instance, an AWS EBS volume attachment is created. It also specifies the EC2 instance (i.e., instance_id) and EBS volume (i.e., volume_id) for the attachment using the each.key object attribute.
// Please note that in the data block example given above, there is a one-to-one relationship between these objects (e.g., data.aws_instance.test_server and aws_ebs_volume.test_server_drive), and as a result, you can use one resource as the for_each of another. This is referred to as Chaining for_each Between Resources.
// Using for_each in module blocks
// Now, let’s see an example of how for_each can be used in a module block:
// # child module - variables.tf
// variable "instance_type" {
//   type    = string
//   default = "t2.micro"
// }

// # child module - ec2_instances.tf
// resource "aws_instance" "qa" {
//   ami           = "ami-0078ef784b6fa1ba4"
//   instance_type = var.instance_type
//   tags = {
//     Environment = "qa"
//   }
// }

// # root module - locals.tf
// locals {
//   qa_instances = {
//     "qa_server_1" = { instance_type = "t2.small" },
//     "qa_server_2" = { instance_type = "t2.micro" },
//     "qa_server_3" = { instance_type = "t2.nano" },
//   }
// }

// # root module - main.tf
// module "virtual_servers" {
//   source   = "./modules/virtual_servers"
//   for_each = local.qa_instances

//   instance_type = each.value.instance_type
// }
// In Terraform, modules are used to abstract implementation configurations of infrastructure objects to be provisioned. They help with infrastructure object reusability by organizing these resources into small and manageable components. A module is basically a directory with terraform configuration files. A root module is a module that calls the child module.
// In the example above, the virtual_servers module is reused to create multiple virtual ec2 instances using the for_each meta-argument. For each EC2 instance specified in the local value (i.e., qa_instances), a virtual server is created. Also, each.value is used to assign an instance_type for each EC2 instance in each iteration.
// Please note that the above example uses a local module. You can also use modules in Terraform’s public registry.
// So far, we have seen examples of how for_each can be used in a resource, data, or module block. for_each also works with a special kind of block called dynamic blocks. Let’s take a look at an example in the next section.
// For_each with dynamic blocks
// In terraform, dynamic blocks are commonly used to construct repetitive nested blocks without duplicating code. The for_each meta-argument is commonly used in a dynamic block to achieve the desired result. See the code snippet below:
// resource "aws_security_group" "test_sg" {
//   name   = "test_sg"
//   vpc_id = var.vpc_id

//   dynamic "ingress" {
//     for_each = var.ingress_ports
//     content {
//       from_port   = ingress.value
//       to_port     = ingress.value
//       protocol    = "tcp"
//       cidr_blocks = ["0.0.0.0/0"]
//       description = "Allows ingress for port ${ingress.value}"
//     }
//   }
// }
// In the code snippet above, we are creating an AWS security group resource that will allow ingress traffic into the VPC specified with the vpc_id variable. So, instead of duplicating the nested ingress block, a dynamic block in the resource block can dynamically construct repeatable ingress blocks using for_each. In a dynamic block, the name of the block (e.g., ingress in the example above) is used instead of each. So, using for_each with a dynamic block, you can easily create multiple nested blocks.
// Please note that dynamic blocks in Terraform can also be used inside other block types, which include data, provider, and provisioner blocks.
// Key considerations when working with the for_each meta-argument
// We have seen several examples of how the for_each meta-argument can be used. Below are some things to keep in mind when working with for_each.
// Referencing blocks and block instances
// Blocks that use the for_each meta-argument (i.e., resource, data, and module blocks) create multiple infrastructure instances. So, how does terraform refer to each of these instances and also the block itself? Let’s see how.
// Referring to the block: use <block_type>.<block_name>. Below are examples of references for block types.
// •	Resource block: <resource_type>.<resource_name> e.g. aws_instance.test_server
// •	Data block: data.<resource_type>.<resource_name> e.g. data.aws_ebs_volume.test_server_drive
// •	Module block: module.<module_name> e.g. module.virtual_servers
// Referring to the instance: use <block_type>.<block_name>[<key>]. Below are examples of references for instances that use for_each.
// •	Resource block: <resource_type>.<resource_name>[<key>] e.g. aws_ebs_volume.test_server_drive[“test_server_drive_1”]. In the earlier section, “Using for_each in data blocks”, we saw an expression like aws_ebs_volume.test_server_drive[each.key].id - The each.key attribute here references each key of the map object (i.e., a map of AWS EBS volumes created for each EC2 instance) used in for_each expression in that block.
// •	Data block: data.<resource_type>.<resource_name>[<key>] e.g. data.aws_instance.test_server[“test_server_1”]. An example is also seen in the “Using for_each in data blocks” section.
// •	Module block: module.<module_name>[<key>] e.g. module.virtual_servers[“test_server_1”]
// For a module that creates multiple instances of a specified resource, the instances are prefixed with the module.<module_name>[<key>] in the Terraform UI. Below are trimmed-down versions of the terraform plan output for the module used in the “Using for_each in module blocks” section:
   
// Limitations with for_each
// for_each keys (i.e., the keys of a map) or values (i.e., the values in a set) which are used for iteration serve as identifiers for the multiple resources they create. As such, they are always visible in the terraform UI output (i.e., terraform plan or terraform apply steps) and also in the state file. Hence, sensitive values cannot be used as arguments in for_each implementations. The sensitive values that can’t be used include:
// •	Sensitive input variables: variables with the sensitive argument set to true.
// •	Sensitive outputs: outputs with the sensitive argument set to true.
// •	Sensitive resource attributes: attributes with sensitive information marked as sensitive using the built-in sensitive function.
// You will get an error if you try using sensitive values as for_each arguments.
// Also, the keys or values of a for_each have to be known before a terraform apply operation. These keys or values cannot also depend on the result of any impure function like timestamp because they are evaluated later on during the main evaluation step. Also, use descriptive keys or values. Since for_each values identify resources, using meaningful keys or values helps to easily identify resources.
// Expressions with for_each
// The types of values used with for_each have to be a set or a map. If you have a list of values, you can use the toset type conversion function to convert it to a set, as seen in the “Using for_each in resource blocks” section.
// Also, you may have nested data structures that are not a suitable value to work with for_each. You can use the for construct or any helpful built-in function like flatten to build up a suitable value for the for_each meta-argument. See example code snippets below:
// # variables.tf
// variable "sandboxes" {
//   type = list(object({
//     name          = string
//     instance_type = string
//   }))
//   default = [
//     {
//       name          = "sandbox_1"
//       instance_type = "t2.small"
//     },
//     {
//       name          = "sandbox_2"
//       instance_type = "t2.micro"
//     },
//     {
//       name          = "sandbox_3"
//       instance_type = "t2.nano"
//     },
//   ]
// }

// # locals.tf
// locals {
//   flat_sandboxes = {
//     for sandbox in var.sandboxes :
//     sandbox.name => sandbox
//   }
// }

// # main.tf
// resource "aws_instance" "example" {
//   for_each = local.flat_sandboxes

//   instance_type = each.value.instance_type
//   ami           = var.ami
//   tags = {
//     Name = each.value.name
//   }
// }
// The code snippet above shows how to use the for construct to prepare a suitable value for the for_each meta-argument. The locals block in terraform is used to assign a name to an expression for reuse as many times as desired. See how local.flat_sandboxes looks like:
 
// As you can see, flat_sandboxes is a map of objects which is what is expected by the for_each meta-argument.
// Please also note that Terraform does not support nested loops in the resource block. You can only use one for_each meta-argument, and it cannot be nested. Hence, the use of a local block above for the nested loop operation.
// Chaining for_each
// As seen in the “Using for_each in data blocks” section, you can use one resource as the for_each of another when there is a one-to-one relationship between these objects. Since an AWS EC2 instance is commonly associated with an AWS EBS volume for storage, if you provision multiple EC2 instances using for_each, then you can chain that for_each into another resource to create an EBS for every EC2 instance.
// Now, you might be thinking and scratching your head, saying, I thought you said that the keys or values of a for_each must be known before a terraform apply.
// Remember the example given earlier in the “Using for_each in data blocks” section? The for_each expression used in the aws_ebs_volume.test_server.drive block references data.aws_instances.test_server, which also references var.instance_ids in the data block. The var.instance_ids variable has known values that the data block uses to retrieve already existing EC2 instances, and then the resource block uses these EC2 instances in the for_each expression to create an EBS volume per EC2 instance.
// Performance considerations when using for_each
// Below are some best practices to adhere to when working with for_each:
// •	Use for_each cautiously as it can impact performance. This is because for_each increases the number of API calls made to a provider for every infrastructure object provisioned.
// Test your Terraform mastery with our free Terraform Challenges. They will help in polishing your infrastructure provisioning and management skills!
// FAQ
// Below are some of the frequently asked questions about for_each.
// When should I use for_each instead of count?
// for_each is commonly used when you need to create similar infrastructure objects that have distinct values. Also, if you do not want the unintended changes that come with using count when modifying your infrastructure object.
// If your resource instances are identical and not impacted by the unintended changes that count causes during modification, then you can use the count meta-argument.
// Can you use both for_each and count meta-arguments in the same block?
// Since both serve a similar purpose which is to create multiple instances of a resource, you can only use one of them. You cannot use both in the same resource block.
// Conclusion
// You have learned why Terraform introduced for_each and also seen several examples of how for_each can be used. Even though for_each gives you flexibility; you need to be mindful when using it, especially in large-scale deployments, to avoid performance degradation, as highlighted earlier.
