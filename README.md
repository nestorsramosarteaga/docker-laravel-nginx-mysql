# docker-laravel-nginx-mysql

This project uses Docker to set up a development environment for **Laravel**, **Nginx**, **MySQL**, and **PHP-FPM**.

---

## 🚀 Steps to Start the Environment

### 1. Copy the example environment file
```bash
cp .env.example .env
```

### 2. Update the following variables in the .env file:
- APP_NAME
- SRV_PORT_HOST
- DB_PORT_HOST
- DB_ROOT_PASSWORD
- DB_DATABASE
- DB_USERNAME
- DB_PASSWORD

### 3. Build the Docker containers
```bash
docker compose build
```

### 4. Start the Docker containers
```bash
docker compose up -d
```

### 5. Open a shell inside the PHP-FPM container
```bash
docker compose exec -it APP_NAME-php-fpm bash
```

> 📝 **Note:** Replace APP_NAME with the value you defined in your .env file.


### 6. Install PHP dependencies using Composer
```bash
composer install
```

### 7. Generate the Laravel application key
```bash
php artisan key:generate
```

### 8. Test the application in your browser
```bash
http://localhost:SRV_PORT_HOST
```

> 📝 **Note:** Replace SRV_PORT_HOST with the value set in your .env file.