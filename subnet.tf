
# Create var.az_count private subnets, each in a different AZ
resource "aws_subnet" "private1" {
  cidr_block        = var.subnet_private1
  availability_zone = "${var.region}a"
  vpc_id            = aws_vpc.main.id
  tags = {
      Name = "${var.layer}-${var.stack_id}-subnet-private1"
  }
}

resource "aws_subnet" "private2" {
  cidr_block        = var.subnet_private2
  availability_zone = "${var.region}b"
  vpc_id            = aws_vpc.main.id
  tags = {
      Name = "${var.layer}-${var.stack_id}-subnet-private2"
  }
}

resource "aws_subnet" "private3" {
  cidr_block        = var.subnet_private3
  availability_zone = "${var.region}c"
  vpc_id            = aws_vpc.main.id
  tags = {
      Name = "${var.layer}-${var.stack_id}-subnet-private3"
  }
}

# Create var.az_count public subnets, each in a different AZ
resource "aws_subnet" "public1" {
  cidr_block              = var.subnet_public1
  availability_zone       = "${var.region}a"
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
  tags = {
      Name = "${var.layer}-${var.stack_id}-subnet-public1"
  }
}

resource "aws_subnet" "public2" {
  cidr_block              = var.subnet_public2
  availability_zone       = "${var.region}b"
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
  tags = {
      Name = "${var.layer}-${var.stack_id}-subnet-public2"
  }
}

resource "aws_subnet" "public3" {
  cidr_block              = var.subnet_public3
  availability_zone       = "${var.region}c"
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
  tags = {
      Name = "${var.layer}-${var.stack_id}-subnet-public3"
  }
}