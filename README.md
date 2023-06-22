# ProyectoFinalBack

## Para Luismi y Miguel

- **Observaciones:** En primer lugar, me gustaría destacar que practicamente todo el código de este proyecto es 'ORIGINAL' (teniendo en cuenta que claramente me he basado en ejemplos de internet, profesor, etc... pero nunca copiado o adaptado el código de mis compañeros).
### Web

- **Login:** Se crea un formulario de login al cual se accederá nada más se runea el proyecto. De hecho no se puede acceder a ningún otro enlace hasta que se introduzcan los datos de un usuario administrador.

- **Panel de usuarios:** En este panel de control se puede administrar los roles de los usuarios ya existentes y banearlos. El mismo usuario que está logeado, como es evidente, no podrá banearse a sí mismo.

- **Panel de posts:** En este panel de control se puede acceder a una vista previa del post y borrarlo si lo estima oportuno.

- **Nav:** Se añade un componente común para todas las paginas(menos login) que dispone de un dropdown que nos dará la opción de hacer logout.

Se entiende que configuraciones como el routing o guards no deben incluirse en las funcionalidades. 

### API

- **UserController:** Todos los siguientes endpoints necesitan autenticación por parte de un administrador

    - **Get users:** Vista de una lista de usuarios para el panel de control de usuarios.
    - **Ban:** Se añaden dos nuevos endpoints, uno para banear y otro para quitar el baneo.
    - **Editar Roles:** Endpoint para editar los roles de un usuario
    - **Ver roles:** Ver los roles que tiene un usuario

- **PostController:** Todos los siguientes endpoints necesitan autenticación por parte de un administrador

    - **Get posts:** Vista de una lista de posts para el panel de control de posts.
    - **Delete post:** Borrar un post.
    - **Get One post:** Vista de un post para el panel de control de posts.

- **Otras modificaciones:**

    - **Seguridad:** Se cambia la seguridad para que funcione correctamente, en vez de /auth/admin/** -> /admin/** 
    - **Dto y Views:** Se modifican o añaden para responder correctamente a las demandas de los endpoints.

## Features

- **API with Spring:** This part of the application is developed using the Spring framework. It provides an Application Programming Interface (API) to access and manage application data. It includes endpoints for CRUD (Create, Read, Update, Delete) operations and is based on technologies like Java and Spring Boot.

- **Administrator with Angular 14:** The administration interface of the application is built with Angular 14. It provides an admin panel and user-friendly interface to manage and visualize application data. It uses Angular components, services, routing, guards and interceptors to provide a secure experience. Link to documentation -> https://github.com/ProgramadorIV/SocialRides/tree/develop-web/Social-Rides-Admin.

## Social Rides API

The users provided to test this API are:

| Username | Password |
| --- | --- |
| Admin | admin |
| User | user |

Getting Started
---------------

To use the Weather API, you will need to login to obtain a Token in order to access to certain endpoints. You can obtain this token by the signing up and login with the endpoints indicated below.

Once you have a token, you can make requests to the API using the url <http://localhost:8080> followed by the following endpoints:

Endpoints
---------

This API provides the following endpoints:

### User

Login ->
`POST /auth/login`
Logs in the user and returns an authentication token.


Register ->
`POST /auth/register`
Registers a new user. The request must contain the user´s username and password.


Change Password ->
`PUT /auth/user/changePassword`
Changes the user password. The request must contain the old password, the new password and a verification of the new password.


Get User Profile ->
`GET /user/{username}`
Gets the user's profile for the given username.


Edit User Details ->
`PUT /auth/user/edit`
Updates the user's details. The request must contain the new data for the user (name, surname, email, birthday) and an optional profile picture.


Get Liked Posts ->
`GET /auth/user/like`
Gets the posts that the user has liked.


Get My Profile ->
`GET /auth/user/profile`
Gets the profile of the currently authenticated user.


### Admin

Register Admin ->
`POST /auth/register`
Registers a new admin user. The request must contain the user's username and password.

### Post

Create Post -> 
`POST /auth/post/{postId}`
Creates a new post. The request must contain the post´s title and location.


Get All Posts ->
`GET /post`
Gets all the posts.


Get One Post ->
`GET /post/{postId}`
Gets the post for the given id.


Edit Post ->
`UPDATE /auth/post/{postId}`
Edits the post for the given id. The request must contain the title, description, location and an optional picture.


Get User Posts ->
`GET /auth/post`
Gets the post published by the logged user.


Delete Post ->
`DELETE /auth/post/{postId}`
Deletes the post for the given id.


Error Handling
--------------

If an error occurs while processing a request, the API will return an error code and a message describing the error.

| Error Code | Description |
| --- | --- |
| 400 | Bad Request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not Found |
| 500 | Internal Server Error |

Support and Contact Information
-------------------------------

If you need help using the Social Rides API you can contact us at <antoniojz1998@gmail.com>.