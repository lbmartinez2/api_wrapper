
# API Wrapper Project

The project is done for studying how the API wrapper works. The goal is to return a rendered JSON page based on the data received from the api without using views.


## Installation

Gems used
  webmock
  rest-client

Install gems

```bash
  bundle install
```
    
## Environment Variables

To run this project, you will need to add the following environment variables to your .env file

`API_KEY`


## API Reference

#### Base URL

```http
  https://api.rawg.io/api
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required** |

## Request
````http
    https://api.rawg.io/api#{endpoint}?key=#{API_KEY}/#{:id}"
````

#### Get all Creators/Games

```http
  GET /api/creators
  GET /api/games
```

#### Get Creator/Game

```http
  GET /api/creators/${id}
  GET /api/games/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `string` | **Required**. Id of item to fetch |


## Running Tests

To run tests, run the following command

```bash
  bundle exec rspec
```


## Authors

- [@lbmartinez2](https://github.com/lbmartinez2)

