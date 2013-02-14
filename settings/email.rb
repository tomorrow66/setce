set :mail_server, {
  address: '',
  port: '',
  enable_starttls_auto: true,
  user_name: '',
  password: '',
  authentication: :plain
}

# Example using GMail:
# set :mail_server, {
#   address: 'smtp.gmail.com',
#   port: '587',
#   enable_starttls_auto: true,
#   user_name: 'you@gmail.com', # Google Apps domains also work here
#   password: '********',
#   authentication: :plain
# }