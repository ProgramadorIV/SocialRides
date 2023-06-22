import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { PageResponse } from '../interfaces/PageResponse';
import { PostItem } from '../interfaces/posts/responses/post-item';
import { Observable } from 'rxjs';
import { PostDetails } from '../interfaces/posts/responses/post-details';

@Injectable({
  providedIn: 'root'
})
export class PostService {

  constructor(private http: HttpClient) { }

  getPosts(page: number=0, size: number=25, sort: string='', search: string=''): Observable<PageResponse<PostItem>>{
    return this.http.get<PageResponse<PostItem>>(
      `${environment.baseUrl}/admin/posts?page=${page}&size=${size}&\$=${search}&sort=${sort}`
    );
  }

  deletePostById(postId: number){
    return this.http.delete(`${environment.baseUrl}/admin/post/${postId}`);
  }

  getPostById(postId: number): Observable<PostDetails>{
    return this.http.get<PostDetails>(`${environment.baseUrl}/admin/post/${postId}`);
  }
}
