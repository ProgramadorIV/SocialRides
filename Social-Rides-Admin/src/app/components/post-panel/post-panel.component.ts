import { Component, OnInit, ViewChild } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import { MatTableDataSource } from '@angular/material/table';
import { PostItem } from 'src/app/interfaces/posts/responses/post-item';
import { PostService } from 'src/app/services/post.service';
import { environment } from 'src/environments/environment';
import { ViewPostModalComponent } from './view-post-modal/view-post-modal.component';
import * as alertify from 'alertifyjs';

@Component({
  selector: 'app-post-panel',
  templateUrl: './post-panel.component.html',
  styleUrls: ['./post-panel.component.css']
})
export class PostPanelComponent implements OnInit {

  dataSource!: MatTableDataSource<PostItem>;
  @ViewChild(MatPaginator) paginator!: MatPaginator;
  @ViewChild(MatSort) sort!: MatSort;

  paginatedUsers: PostItem[] = [];
  currentPage = 0;
  totalPages = 0;
  totalElements = 0;
  last = true;
  first = true;
  username: any;
  size = 50;
  imgBaseUrl: any;

  constructor(private service: PostService, private dialog: MatDialog) { }

  ngOnInit(): void {
    this.imgBaseUrl = environment.baseUrl;
    this.getPosts(0, 50, '', '');
  }

  displayedColumns = ['id', 'title', 'location', 'username', 'publishedAt', 'likes', "comments", "action"];

  getPosts(page: number, size: number, sort: string, search: string) {
    this.service.getPosts(page, size, sort, search).subscribe(item => {
      this.paginatedUsers = item.content;
      this.dataSource = new MatTableDataSource<PostItem>(this.paginatedUsers);
      this.dataSource.paginator = this.paginator;
      this.currentPage = item.currentPage;
      this.totalPages = item.totalPages;
      this.totalElements = item.totalElements;
      this.last = item.last;
      this.first = item.first;
    });
  }

  view(postId: any) {
    let popup= this.dialog.open(ViewPostModalComponent,{
       width:'50%',
       height:'75%px',
       exitAnimationDuration:'1000ms',
       enterAnimationDuration:'1000ms',
       data:{
         postId: postId
       }
     })
     popup.afterClosed().subscribe(()=>{
       this.getPosts(this.currentPage, this.size, '', '');
     })

   }

   delete(postId: any){
    alertify.confirm("Deleting post","do you want to delete this post?",()=>{
      this.service.deletePostById(postId).subscribe(()=> {
        this.getPosts(this.currentPage, this.size, '', '');
        alertify.success("Post deleted successfully");
      });

    },function(){})
   }
}
