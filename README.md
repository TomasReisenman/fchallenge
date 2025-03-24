# fchallenge

## Build Project with Docker

```
docker build -t fchallenge .

```

## Run the project with Docker

``` 
docker run -p 9292:9292 -it fchallenge

```

## Run the project without Docker ( requires ruby tool chain )

``` 
docker run -p 9292:9292 -it fchallenge

```

## Tests can be run with

```
ruby test\test.rb

```

