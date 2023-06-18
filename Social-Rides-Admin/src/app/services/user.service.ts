import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { UserLogRequest } from '../interfaces/users/request/user-log-request';
import { UserLogged } from '../interfaces/users/response/user-logged';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(private http: HttpClient ) { }

}
