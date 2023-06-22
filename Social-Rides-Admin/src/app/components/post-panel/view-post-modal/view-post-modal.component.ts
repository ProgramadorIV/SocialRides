import { Component, Inject, OnInit , AfterViewInit} from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { PostService } from 'src/app/services/post.service';
import * as alertify from 'alertifyjs';
import { environment } from 'src/environments/environment';


@Component({
  selector: 'app-view-post-modal',
  templateUrl: './view-post-modal.component.html',
  styleUrls: ['./view-post-modal.component.css']
})
export class ViewPostModalComponent implements OnInit {

  constructor(private service: PostService, @Inject(MAT_DIALOG_DATA) public data: any,
  private ref:MatDialogRef<ViewPostModalComponent>) { }

  post: any;

  ngOnInit(): void {
    this.getPost(this.data.postId);
  }

  getPost(postId: number){
    this.service.getPostById(postId).subscribe((item) => {
      this.post = item;
      if(item==null)
        alertify.error('Failed to fetch post data.');
    });
  }

  getImg(){
    return `${environment.baseUrl}/download/${this.post.img}`;
  }


}
