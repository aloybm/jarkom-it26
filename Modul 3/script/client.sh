apt update
apt install lynx -y
apt install htop -y
apt install apache2-utils -y
apt-get install jq -y

# POST Register
echo '
{
  "username": "kelompokit26",
  "password": "passwordit26"
}' > register.json

# POST Login
echo '
{
  "username": "kelompoka09",
  "password": "passworda09"
}' > login.json