package com.salesianos.socialrides.search.spec;



import com.salesianos.socialrides.model.comment.Comment;
import com.salesianos.socialrides.model.like.Likee;
import com.salesianos.socialrides.model.post.Post;
import com.salesianos.socialrides.model.user.User;
import com.salesianos.socialrides.search.util.SearchCriteria;
import org.springframework.data.jpa.domain.Specification;

import java.lang.reflect.Field;
import java.util.List;

public class GenericSpecificationBuilder<T>{

    private List<SearchCriteria> params;

    private Class<T> clazz;

    final List<String> classes= List.of(
            Post.class.getSimpleName().toLowerCase(),
            User.class.getSimpleName().toLowerCase(),
            Likee.class.getSimpleName().toLowerCase(),
            Comment.class.getSimpleName().toLowerCase());

    public GenericSpecificationBuilder(List<SearchCriteria> params, Class<T> clazz){
        this.params = params;
        this.clazz = clazz;
    }

    public Specification<T> build(){
        List<SearchCriteria> filteredCriteria = params.stream().filter(p -> {
            for(Field field : clazz.getDeclaredFields()){
                return p.getKey().equalsIgnoreCase(field.getName())
                        ||
                        !classes.contains(p.getKey().toLowerCase());
            }
            return false;
        }).toList();

        if(filteredCriteria.isEmpty())
            return null;

        Specification<T> result = new GenericSpecification<>(params.get(0));

        for (SearchCriteria param : params) {
            /*todo- Arreglo no definitivo en el caso de que el campo tenga camelcase*/
            param.setKey(param.getKey().toLowerCase());
            result = result.and(new GenericSpecification<>(param));
        }

        return result;
    }

}
