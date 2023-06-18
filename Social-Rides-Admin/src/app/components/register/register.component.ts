import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MaterialModule } from 'src/material-module';
import { animate, style, transition, trigger } from '@angular/animations';
import { AuthenticationService } from 'src/app/services/authentication.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css'],
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
export class RegisterComponent implements OnInit {

  response: any;

  constructor(private authenticationService: AuthenticationService, private route: Router) { }

  ngOnInit(): void {
  }

  register(registerRequest: any){
    if(registerRequest.valid){
      this.authenticationService.register(registerRequest.value).subscribe({
        next: (data) => {
          if(this.response){

          }
        },
        error: (e) => {
          this.showErrors();
        }
      })
    }
  }

  showErrors(){

  }

}
