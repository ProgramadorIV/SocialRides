package com.salesianos.socialrides.view;

public class View {

    public static interface PostView{

        public static interface PostListView{}

        public static interface ListAdminView{}

        public static  interface ItemAdminView {}

        public static interface PostWithEverythingView{}
    }

    public static interface UserView{

        public static interface ProfileView{}

        public static interface DetailsView{}

        public static interface CreatedView{}

        public static interface LoggedView{}

        public static interface ListView {
        }

        public static interface ListAdminView{}
    }

    public static interface LikesView{}
    public static interface CommentsView{}

    public static interface PageView{}
}
