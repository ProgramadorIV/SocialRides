import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MaterialModule } from 'src/material-module';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { UserLogRequest } from 'src/app/interfaces/users/request/user-log-request'
import { UserLogged } from 'src/app/interfaces/users/response/user-logged';
import { AuthenticationService } from 'src/app/services/authentication.service';
import { animate, style, transition, trigger } from '@angular/animations';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
  animations: [
    trigger('slideIn', [
      transition(':enter', [
        style({ opacity: 0 }),
        animate('500ms', style({ opacity: 1 }))
      ]),
      transition(':leave', [
        style({opacity: 0}),
        animate('500ms', style({ opacity: 1 }))
      ])
    ])
  ]
})

export class LoginComponent implements OnInit {

  photoUrl = 'https://wallpapercave.com/wp/wp2892907.jpg';
  response: any;

  constructor(private authenticationService: AuthenticationService, private route: Router) { }

  ngOnInit(): void {
  }

  login(userRequest: any){
    if (userRequest.valid) {
      this.authenticationService.login(userRequest.value).subscribe({
        next: (data) => {
          this.response=data;
          if(this.response.admin){
            localStorage.setItem('token',this.response.token);
            localStorage.setItem('avatar', this.response.avatar);
            localStorage.setItem('username', this.response.username);
            this.route.navigate(['home']);

          }else{
            alert("Bad credentials");
          }
        },
        error: (_) => {
          alert("Bad credentials");
        }
      });
    }
  }

}
