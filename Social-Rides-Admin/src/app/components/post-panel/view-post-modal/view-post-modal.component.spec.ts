import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ViewPostModalComponent } from './view-post-modal.component';

describe('ViewPostModalComponent', () => {
  let component: ViewPostModalComponent;
  let fixture: ComponentFixture<ViewPostModalComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ViewPostModalComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ViewPostModalComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
