import { NgModule } from "@angular/core";
import { MatButtonModule } from "@angular/material/button";
import { MatCard, MatCardModule } from "@angular/material/card";
import { MatFormFieldModule } from "@angular/material/form-field";
import { MatInputModule }  from '@angular/material/input';
import { MatTableModule } from "@angular/material/table";

@NgModule({
  exports: [
    MatCardModule,
    MatFormFieldModule,
    MatInputModule,
    MatButtonModule,
    // MatTableModule
  ]
})
export class MaterialModule {
}
