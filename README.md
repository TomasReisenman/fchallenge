# fchallenge

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

## Tests can be run without Docke with

```
ruby test\test.rb

```

