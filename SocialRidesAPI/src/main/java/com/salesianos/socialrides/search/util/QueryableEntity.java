package com.salesianos.socialrides.search.util;

import com.salesianos.socialrides.model.comment.Comment;
import com.salesianos.socialrides.model.like.Likee;
import com.salesianos.socialrides.model.post.Post;
import com.salesianos.socialrides.model.user.User;
import org.springframework.data.jpa.domain.Specification;

import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.stream.Stream;

public interface QueryableEntity {

    final List<String>classes = List.of("User", "Post", "Comment", "Likee");
    final String classess= "UserPostCommentLike";

    static boolean checkQueryParam(Class clazz, SearchCriteria s) {
        List<Field> fields = List.of(clazz.getDeclaredFields());

        List<Field> filteredFields = fields.stream().filter(f-> classess.contains(f.getDeclaringClass().getSimpleName())).toList();

        for(Field f : filteredFields){
            return f.getName().equalsIgnoreCase(s.getKey());
        }
        return false;


    }
    /*static  boolean checkQueryParams(Class clazz, List<SearchCriteria> searchCriteria){
        for (SearchCriteria s :searchCriteria) {
            if(QueryableEntity.checkQueryParam(clazz, s)){
                return true;
            }
        }
        return false;
    }*/


}
