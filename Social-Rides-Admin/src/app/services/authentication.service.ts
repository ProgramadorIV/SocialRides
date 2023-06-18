import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { UserLogRequest } from '../interfaces/users/request/user-log-request';
import { UserLogged } from '../interfaces/users/response/user-logged';
import { environment } from 'src/environments/environment';
import { RegisterRequest } from '../interfaces/users/request/register-request';
import { RegisteredUser } from '../interfaces/users/response/register-user';

@Injectable({
  providedIn: 'root'
})
export class AuthenticationService {

  constructor(private http: HttpClient) { }

  login(request: UserLogRequest){

    return this.http.post<UserLogged>(`${environment.baseUrl}/auth/login`, request);
  }

  userLogged(){
    return localStorage.getItem("token") != null;
  }

  register(request: RegisterRequest){
    return this.http.post<RegisteredUser>(`${environment.baseUrl}/auth/register`, request);
  }
}
