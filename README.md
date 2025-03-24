# fchallenge

Esta es mi entrega para el challenge tecnico de Fudo. Unas cosas para tener en cuenta:

- Esta app solo usa Ruby, Rack y Puma. No depende de ninguna otra libreria
- Excepto los endpoints de /auth se debe estar autenticado para usar los demas endpoints
- Por simplicidad la app usa una autenticación basada en cookies
- El enpoint /auth otorga una cookie si el usuario y contraseña son correctos
- Durante mis pruebas Postman automaticamente carga la cookie en los siguientes request
- Ya hay un usuario cargado . user : "fudo" , password: "fudochallenge"
- La api esta especificado en openapi.yml

## Build Project with Docker

```
docker build --target base -t fchallenge .

```

## Run the project with Docker

``` 
docker run -p 9292:9292 -it fchallenge

```

## Build Tests with Docker

```
docker build --target test -t fchallenge .

```

## Run the test with Docker

``` 
docker run -p 9292:9292 -it fchallenge

```

## Run the project without Docker ( requires ruby tool chain )

``` 
bundle exec puma

```

## Tests can be run without Docker (requires ruby tool chain )  with

```
ruby test\test.rb

```

## Commands

### 1. Log in a User

``` 
curl -X POST http://localhost:9292/auth \
-H "Content-Type: application/json" \
-d '{"user": "fudo", "password": "fudochallenge"}'
```

### 2. Sign In a New User

```
curl -X POST http://localhost:9292/auth/signin \
-H "Content-Type: application/json" \
-d '{"user": "newuser", "password": "newpassword"}'

```

### 3. Get All Products

```
curl -X GET http://localhost:9292/products \
-H "Cookie: name=<COOKIE>"
```

### 4. Save a New Product

```
curl -X POST http://localhost:9292/products \
-H "Content-Type: application/json" \
-H "Cookie: name=<COOKIE>" \
-d '{"id": 1, "name": "New Product"}'

```

### 5. Get the AUTHORS 

```
curl -X GET http://localhost:9292/AUTHORS \
-H "Cookie: name=<COOKIE>"

```

### 6. Get the OpenAPI Specification


```
curl -X GET http://localhost:9292/openapi.yml \
-H "Cookie: name=<COOKIE>"

```