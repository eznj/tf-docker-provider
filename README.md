## Docker Use via Terraform with Rust/Rocket Framework.

Not much to see here but if you want to look, you can:

```
git clone git@github.com:/nicksort/tf-docker-test
```

If you need it:

```
brew install terraform
```

Initialize Terraform locally:

```
terraform init
```

Assuming you have Docker set up on your machine:

```
terraform apply
```

You can curl your docker host now on port `80` to see the response from the rocket server via nginx

Enjoy!

