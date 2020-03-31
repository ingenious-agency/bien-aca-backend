# Quarantine Control

Server application for the Quarantine Control application.

## Installation

Note: _Make sure you have installed rvm._

```bash
$> git clone git@github.com:ingenious-agency/qc-backend.git
$> cd qc-backend
$> bundle install
```

## Deployment

The app is already connected with a heroku pipeline, just cut a branch and wait for heroku to deploy a new review app. Merges to `master` will deploy [production](https://qc-backend-prod.herokuapp.com/).

## Current features

### Register a user

```bash
$> curl --header "Content-Type: application/json" \
    --request POST \
    --data '{ "user": { "email": "email@test.com", "name": "Test User", "password": "test",  "password_confirmation": "test", "identity_number": "3.482.204-2", "date_of_birth": "1984-03-20", "binary_gender": 0, "cellphone": "099275434", "lat": 1, "long": 1 } }' \
    https://qc-backend-prod.herokuapp.com/users
```

This will register a user that you can later use to log-in.

### Login as a user

```bash
$> curl --header "Content-Type: application/json" \
        --request POST \
        --data '{ "email": "gchertok@gmail.com", "password": "cherta" }' \
        https://qc-backend-prod.herokuapp.com/auth/login

{"token":"eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1ODQ3MTQwOTh9.2aeVZbv6uf2675F4VoYEM7tRLXpDBwE6PMzFzCQS02g","exp":"05-19-2020 11:19","email":"gchertok@gmail.com"}%
```

### Send a heartbeat
```bash
$> curl --header "Content-Type: application/json" \
        --header "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1ODQ3MTQwOTh9.2aeVZbv6uf2675F4VoYEM7tRLXpDBwE6PMzFzCQS02g"
        --request POST \
        --data '{ "time": "gchertok@gmail.com", "lat":"-34.897525", "long":"-56.164746" }' \
        https://qc-backend-prod.herokuapp.com/users/1/heartbeats

```