# Humantask client

## Install and Run

- We need to install NPM, Node and coffeescript

[Node](www.node.org) comes with NPM.

- Once NPM is installed:

`sudo npm install -g coffee-script` to install CoffeeScript

- Then in our project:

`npm install` for installing the dependencies of the project (see package.json)

- Finally:

cd into project, and run `coffee index.coffee` to run the proxy server on `http://localhost:9000`

## Testing

There is a script to test the library "Humantask"

run `coffee test.coffee`

## API

 - GET /authenticate:

  	- @query login
  	- @query password
  	- @return workflowContext, con el token del login seteado en una cookie

- GET /humantask

    - @return array JSON con información sobre las task disponibles al usuario logueado identificado por el token de /authenticate

    
- GET /humantask/:taskId

    -@param taskId, el ID de la task de la que desean los details
    -@return getTaskDetailsById
