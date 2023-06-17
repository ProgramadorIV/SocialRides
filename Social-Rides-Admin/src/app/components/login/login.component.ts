import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  photoUrl = 'https://wallpapercave.com/wp/wp2892907.jpg';

  constructor() { }

  ngOnInit(): void {
  }

  login(){

  }

}
