import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { UserItem } from '../interfaces/users/response/user-item';
import { PageResponse } from '../interfaces/PageResponse';
import { Observable } from 'rxjs';
import { RoleRequest } from '../interfaces/users/request/role-request';

@Injectable({
  providedIn: 'root'
})
export class UserService {

  constructor(private http: HttpClient ) { }

  getUsers(page: number=0, size: number=25, sort: string='', search: string=''):
    Observable<PageResponse<UserItem>>{
    // &sort=UserPanelComponent,desc

    return this.http.get<PageResponse<UserItem>>(
      `${environment.baseUrl}/auth/admin/user?page=${page}&size=${size}&\$=${search}&sort=${sort}`
    );
  }

  banUser(username: string){
    return this.http.put(`${environment.baseUrl}/auth/admin/${username}/ban`, {});
  }

  unBanUser(username: string){
    return this.http.put(`${environment.baseUrl}/auth/admin/${username}/unban`, {});
  }

  editUser(username: string, request: RoleRequest){
    return this.http.put(`${environment.baseUrl}/auth/admin/edit-role/${username}`, request);
  }

}
