import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from './components/login/login.component';
import { UserPanelComponent } from './components/user-panel/user-panel.component';
import { NavigationComponent } from './components/general/navigation/navigation.component';
import { RegisterComponent } from './components/register/register.component';
import { CommentPanelComponent } from './components/comment-panel/comment-panel.component';
import { PostPanelComponent } from './components/post-panel/post-panel.component';
import { StatusPageComponent } from './components/status-page/status-page.component';
import { AuthenticationGuard } from './guards/authentication.guard';
import { animation } from '@angular/animations';
import { DashboardComponent } from './components/home/dashboard.component';

const routes: Routes = [
  {path: 'login', component: LoginComponent},
  {path: 'register', component: RegisterComponent, canActivate: [AuthenticationGuard]},
  {path: '', pathMatch: 'full', redirectTo: 'login'},
  {path: '', component: NavigationComponent, canActivate: [AuthenticationGuard], children: [
    {path: 'home', component: DashboardComponent},
    {path: 'users', component: UserPanelComponent},
    {path: 'posts', component: PostPanelComponent},
    {path: 'comments', component: CommentPanelComponent},
  ]},
  {path: '**', component: StatusPageComponent},
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
