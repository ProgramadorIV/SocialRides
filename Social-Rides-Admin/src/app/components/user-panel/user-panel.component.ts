import { AfterViewInit, Component, OnInit, ViewChild } from '@angular/core';
import { map } from 'rxjs';
import { UserService } from 'src/app/services/user.service';
import { UserItem } from 'src/app/interfaces/users/response/user-item';
import { MatTableDataSource } from '@angular/material/table';
import { MatDialog } from '@angular/material/dialog';
import { MatPaginator } from '@angular/material/paginator';
import { MatSort } from '@angular/material/sort';
import * as alertify from 'alertifyjs';
import { EditUserModalComponent } from './edit-user-modal/edit-user-modal.component';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-user-panel',
  templateUrl: './user-panel.component.html',
  styleUrls: ['./user-panel.component.css']
})
export class UserPanelComponent implements OnInit {

  dataSource!: MatTableDataSource<UserItem>;
  @ViewChild(MatPaginator) paginator!: MatPaginator;
  @ViewChild(MatSort) sort!: MatSort;

  paginatedUsers: UserItem[] = [];
  currentPage = 0;
  totalPages = 0;
  totalElemets = 0;
  last = true;
  first = true;
  username: any;
  size = 25;
  imgBaseUrl: any;

  constructor(private service: UserService, private dialog: MatDialog) { }

  ngOnInit(): void {
    this.imgBaseUrl = environment.baseUrl;
    this.getUsers(0, 25, '', '');
    this.username = localStorage.getItem('username');
  }

  getUsers(page: number, size: number, sort: string, search: string) {
    this.service.getUsers(page, size, sort, search).subscribe(item => {
      this.paginatedUsers = item.content;
      this.dataSource = new MatTableDataSource<UserItem>(this.paginatedUsers);
      this.dataSource.paginator = this.paginator;
      this.currentPage = item.currentPage;
      this.totalPages = item.totalPages;
      this.totalElemets = item.totalElements;
      this.last = item.last;
      this.first = item.first;
    });
  }
  displayedColumns = ['avatar', 'username', 'fullname', "birthday", "email", "createdAt", "posts", "enabled", "admin", "action"];

  update(user: any) {

   let popup= this.dialog.open(EditUserModalComponent,{
      width:'400px',
      height:'300px',
      exitAnimationDuration:'1000ms',
      enterAnimationDuration:'1000ms',
      data:{
        user:user
      }
    })
    popup.afterClosed().subscribe(()=>{
      this.getUsers(this.currentPage, this.size, '', '');
    });

  }
  ban(username: any) {
    alertify.confirm("Banning user","do you want to ban this user?",()=>{
      this.service.banUser(username).subscribe(()=> {
        this.getUsers(this.currentPage, this.size, '', '');
        alertify.success("User banned successfully");
      });

    },function(){})

  }
  unban(username: any) {
    alertify.confirm("Enabling user account","do you want to unban this user?",()=>{
      this.service.unBanUser(username).subscribe(()=> {
        this.getUsers(this.currentPage, this.size, '', '');
        alertify.success("User unbanned successfully");
      });

    },function(){})

  }

}
