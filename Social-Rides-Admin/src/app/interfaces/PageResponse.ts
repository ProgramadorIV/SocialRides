import { UserItem } from './users/response/user-item';

export interface PageResponse<T> {
  content: T[];
  currentPage: number;
  totalPages: number;
  totalElements: number;
  last: boolean;
  first: boolean;
}

// "content": [
//     {
//         "id": "4ae23df7-4194-4941-8a9d-4890c37c3d30",
//         "username": "User",
//         "avatar": "",
//         "name": "Antonio",
//         "surname": "Jiménez",
//         "birthday": "1998-09-21",
//         "email": null,
//         "createdAt": "17/06/2023 11:42:16",
//         "enabled": true,
//         "posts": 0
//     },
// "currentPage": 0,
// "totalPages": 1,
// "totalElements": 3,
// "last": true,
// "first": true
