export interface UserLogged{
  id: string,
  username: string,
  avatar: string,
  name: string,
  surname: string,
  birthday: string,
  email: string,
  createdAt: string,
  token: string,
  refreshToken: string,
  admin: boolean
}

// {
//   "id": "4ae23df7-4194-4941-8a9d-0310c37c3d30",
//   "username": "Admin",
//   "avatar": "",
//   "name": "Clara",
//   "surname": "Infante",
//   "birthday": "1998-12-13",
//   "email": "admin@gmail.com",
//   "createdAt": "18/06/2023 12:55:06",
//   "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI0YWUyM2RmNy00MTk0LTQ5NDEtOGE5ZC0wMzEwYzM3YzNkMzAiLCJpYXQiOjE2ODcwODczNTcsImV4cCI6MTY4NzA4OTE1N30.aH9WssTEFZ0crzVaLp8PSZLDkrYFkzh82j1VIiAl8pZQCr5B1RwaSUWIBUBs2MzcqEBC2b_Jo-PiLAxEXN9uIA",
//   "refreshToken": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI0YWUyM2RmNy00MTk0LTQ5NDEtOGE5ZC0wMzEwYzM3YzNkMzAiLCJpYXQiOjE2ODcwODczNTcsImV4cCI6MTY4NzA4OTE1N30.aH9WssTEFZ0crzVaLp8PSZLDkrYFkzh82j1VIiAl8pZQCr5B1RwaSUWIBUBs2MzcqEBC2b_Jo-PiLAxEXN9uIA"
// }
