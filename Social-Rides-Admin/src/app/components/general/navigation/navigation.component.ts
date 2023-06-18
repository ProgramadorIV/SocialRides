import { Component, OnInit } from '@angular/core';
import { BreakpointObserver, Breakpoints } from '@angular/cdk/layout';
import { Observable } from 'rxjs';
import { map, shareReplay } from 'rxjs/operators';
import { Router } from '@angular/router';
import { UserLogged } from 'src/app/interfaces/users/response/user-logged';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-navigation',
  templateUrl: './navigation.component.html',
  styleUrls: ['./navigation.component.css']
})
export class NavigationComponent implements OnInit{

  visible = true;
  imgBaseUrl: any;
  avatar: any;

  isHandset$: Observable<boolean> = this.breakpointObserver.observe(Breakpoints.Handset)
    .pipe(
      map(result => result.matches),
      shareReplay()
    );

  constructor(private breakpointObserver: BreakpointObserver, private route: Router) {}
  ngOnInit(): void {
    this.imgBaseUrl = environment.baseUrl;
    this.avatar = localStorage.getItem('avatar');
  }

  logOut(): void{
    localStorage.clear();
    this.route.navigate(['login']);
  }

  // ngDoCheck(): void {
  //   const actualRoute = this.route.url;

  //   if(actualRoute == '/login' || actualRoute == '/register'){
  //     this.visible = false;
  //   }
  // }





}
