server {
    listen 80;
    server_name paymentapp.thelastimperial.com;

    # Tell Nginx and Passenger where your app's 'public' directory is
    root /var/www/PaymentApp/public;

    # Turn on Passenger
    passenger_enabled on;
    passenger_ruby /usr/share/rvm/rubies/ruby-3.2.2/bin/ruby;

    passenger_env_var RAILS_ENV production;
    passenger_env_var DATABASE_URL postgresql://postgres:PWD@localhost:5432/payment_app;
    passenger_env_var SECRET_KEY_BASE KEY;

}
