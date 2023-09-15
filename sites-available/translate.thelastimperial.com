server {
    listen 80;
    server_name translate.thelastimperial.com;

    # Tell Nginx and Passenger where your app's 'public' directory is
    root /var/www/translate-words;

    index index.html;

}
