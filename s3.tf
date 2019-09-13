resource "aws_s3_bucket" "beer_catalog_bucket" {
  bucket = "beer-catalog-app"
  acl = "public-read"
  website {
    index_document = "index.html"
  }

  tags = {
    Name = "Beer Catalog App"
  }
}

resource "aws_s3_bucket_policy" "beer_catalog_site" {
  bucket = "${aws_s3_bucket.beer_catalog_bucket.id}"
  policy = "${data.aws_iam_policy_document.beer_catalog_public_access.json}"
}

data "aws_iam_policy_document" "beer_catalog_public_access" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket"

    ]

    resources = [
      "${aws_s3_bucket.beer_catalog_bucket.arn}",
      "${aws_s3_bucket.beer_catalog_bucket.arn}/*"
    ]

    principals {
      type = "AWS"
      identifiers = ["*"]
    }
  }
}

output "beer_catalog_site" {
  value = "Beer catalog URL: http://${aws_s3_bucket.beer_catalog_bucket.bucket_regional_domain_name}/index.html"
}
