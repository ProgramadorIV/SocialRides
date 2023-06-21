import { Component, Inject, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { UserService } from 'src/app/services/user.service';
import * as alertify from 'alertifyjs';

@Component({
  selector: 'app-edit-user-modal',
  templateUrl: './edit-user-modal.component.html',
  styleUrls: ['./edit-user-modal.component.css']
})
export class EditUserModalComponent implements OnInit {

  constructor(private service: UserService, @Inject(MAT_DIALOG_DATA) public data: any,
  private ref:MatDialogRef<EditUserModalComponent>) { }

  ngOnInit(): void {
    // this.getRoles();
  }

  roledata: any;
  editdata: any;
  savedata: any;

  roleForm = new FormGroup({
    role: new FormControl("", Validators.required),
  })

  saveUser(){}

  // saveUser() {
  //   if (this.roleForm.valid) {
  //     this.service.editUser(this.roleForm.getRawValue()).subscribe(item => {
  //       this.savedata = item;
  //       if (this.savedata.result == 'pass') {
  //         alertify.success("Updated successfully.")
  //         this.ref.close();
  //       } else {
  //         alertify.error("Failed try again");
  //       }
  //     });
  //   }
  // }

  // getRoles(username: any) {
  //   this.service.getRoles(username).subscribe(item => {
  //     this.editdata = item;
  //     if (this.editdata != null) {
  //       this.roleForm.setValue({ role: this.editdata.role});
  //     }
  //   });

  // }

}
