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

  statement {
    actions = [
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem",
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:BatchGetItem",
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:Scan"
    ]

    resources = [
      "arn:aws:dynamodb:eu-central-1:650008541835:table/game-stats-main"
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
        "Service": ["lambda.amazonaws.com"]
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
