import { Component, Inject, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { UserService } from 'src/app/services/user.service';
import * as alertify from 'alertifyjs';
import { UserRole } from 'src/app/interfaces/users/request/role-request';

@Component({
  selector: 'app-edit-user-modal',
  templateUrl: './edit-user-modal.component.html',
  styleUrls: ['./edit-user-modal.component.css']
})
export class EditUserModalComponent implements OnInit {

  constructor(private service: UserService, @Inject(MAT_DIALOG_DATA) public data: any,
  private ref:MatDialogRef<EditUserModalComponent>) { }

  ngOnInit(): void {
    this.getRoles(this.data.user.username);
  }

  newRoles: UserRole[] = [];
  roledata: any;
  roles: any;
  roleForm = new FormGroup({
    admin: new FormControl(false),
    user: new FormControl(false)
  });

  saveUser() {
    if (this.roleForm.valid) {
      if(this.roleForm.value.admin)
        this.newRoles.push(UserRole.ADMIN);
      if(this.roleForm.value.user)
        this.newRoles.push(UserRole.USER);
      this.service.editUser(this.data.user.username, {roles: this.newRoles}).subscribe({
        next: (data) => {
          alertify.success("Role updated successfully.");
          this.ref.close();
        },
        error: () => {
          alertify.error("Failed try again");
        }
      })
    }
  }

  getRoles(username: any) {
    this.service.getRoles(username).subscribe(item => {
      this.roles = item;
      if (this.roles != null) {
        this.roleForm.setValue({ admin: this.roles.roles.includes('ADMIN'), user: this.roles.roles.includes('USER')});
    }});
  }
}
