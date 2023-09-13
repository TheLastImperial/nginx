server {
	listen 80;
	server_name django.thelastimperial.com;
   	
	root /var/www/django-pkg-thelastimperial;
	passenger_enabled on;

	passenger_app_root /var/www/django-pkg-thelastimperial;
	
	#don't foget to create passenger_wsgi.py on where root files located
	passenger_app_type wsgi;
	#passenger_startup_file passenger_wsgi.py;
	passenger_startup_file thelastimperial/wsgi.py;

	passenger_python /var/www/django-pkg-thelastimperial/.venv/bin/python3;

	passenger_env_var DJANGO_DEBUG False;
	passenger_env_var DB_USER postgres;
	passenger_env_var DB_HOST localhost;
	passenger_env_var DB_NAME django_app;
	passenger_env_var DB_PWD PWD;
	passenger_env_var DJANGO_ALLOWED_HOSTS django.thelastimperial.com,thelastimperial.com;

	#tell passenger, where the /static located
	location /static {
		alias /var/www/django-pkg-thelastimperial/static;
		passenger_document_root /var/www/django-pkg-thelastimperial/static;
	}

	#tell passenger, where the /media located
	location /media {
		alias /var/www/django-pkg-thelastimperial/media;
		passenger_document_root /var/www/django-pkg-thelastimperial/media;
	}
	
	location ~* .(jpg|jpeg|png|gif|ico|css|js)$ {
	expires 365d;
	}

}
