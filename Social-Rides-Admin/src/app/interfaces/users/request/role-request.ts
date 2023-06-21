export enum UserRole {'ADMIN', 'USER'}
export interface RoleRequest{
  roles: UserRole[]
}
