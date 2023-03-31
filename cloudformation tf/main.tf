resource "aws_cloudformation_stack" "network" {
  name = "networking-stack"
  template_body = jsonencode({
    "Resources" : {
      "S3Bucket" : {
        "Type" : "AWS::S3::Bucket",
        "DeletionPolicy" : "Retain",
        "Properties" : {
          "BucketName" : "swathicloudformation1"
        }
      }
    }
  })
}
