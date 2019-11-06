data "aws_iam_policy_document" "x-tg-bot-lambda-policy-document" {
  statement {
    actions = [
      "ssm:DescribeParameters",
      "ssm:GetParameter"
    ]

    resources = [
      "*"
    ]
  }


  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [
      "*"
    ]
  }
}


resource "aws_iam_policy" "x-tg-bot" {
  name   = "x-tg-bot-policy"
  path   = "/"
  policy = "${data.aws_iam_policy_document.x-tg-bot-lambda-policy-document.json}"
}

resource "aws_iam_role" "x-tg-bot-role" {
  name = "x-tg-bot-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["ec2.amazonaws.com"]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "test-attach" {
    role       = "${aws_iam_role.x-tg-bot-role.name}"
    policy_arn = "${aws_iam_policy.x-tg-bot.arn}"
}
