# Smart Package for NodeJS

## Prerequisites
Install [NodeJS](https://nodejs.org/en/download/)

## Run Locally
#### Install packages
```bash
cd webapi
npm install
```

#### Start Server
```npm start```

## How to add new swagger path to code

#### Edit Swagger file
```npm edit```

This should provide the swagger editor for you to setup your swagger path, After setting up your new path, follow next step below.

#### Create controller
Controllers are used to connect your swagger paths to code functionality.
1. To create a controller, you need two important things from your swagger file
   a. **x-swagger-router-controller** - used to map the file containing the code implementation for the API
   
   b. **operationId** - used to map the method handling the specific http request
   
   Swagger content example
   ```yaml
    /test:
        x-swagger-router-controller: test_api
        get:
          description: Returns 'test' to the caller
          operationId: testApi
    ```
2.  Create a file matching the `x-swagger-router-controller` in [api/controllers](api/controllers), in the example above, test_api.js was created.
3.  In your file declare your function and ensure it's export matches the `operationId` declared.
    ```javascript
    module.exports = {
      testApi: testApi
    };
    ```
    Example can be found in [api/controllers/test_api.js](api/controllers/test_api.js)
4. You should be able to test your new code now either through swagger editor or using the url.