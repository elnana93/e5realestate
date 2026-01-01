resource "aws_iam_user" "admin_user" {
  name          = "user_admin3"
  force_destroy = true
  
}

resource "aws_iam_user_policy_attachment" "admin_attach" {
  user       = aws_iam_user.admin_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user_login_profile" "admin_login" {
  user                    = aws_iam_user.admin_user.name
  /* password_length         = 20 */
  password_reset_required = true
  pgp_key                 = file("pgp/final_clean_key.b64")
}


data "aws_caller_identity" "current" {}


# "its official" - 

# terraform output -raw admin_user_encrypted_password | base64 --decode | gpg --decrypt -q

# Output the encrypted password "Hell YEAH!!!!!!!"

# export GPG_TTY=$(tty) -(this is to make sure gpg can prompt you for your passphrase, when you create new terraform project, but still using the same gpg key)