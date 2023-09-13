server {
    listen 80;
    server_name thelastimperial.com;

    # Tell Nginx and Passenger where your app's 'public' directory is
    root /var/www/sudoku;

    index index.html;

}
