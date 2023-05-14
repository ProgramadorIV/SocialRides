package com.salesianos.socialrides.search.spec;



import com.salesianos.socialrides.search.util.SearchCriteria;
import org.springframework.data.jpa.domain.Specification;

import java.util.List;

public class GenericSpecificationBuilder<T>{

    private List<SearchCriteria> params;

    public GenericSpecificationBuilder(List<SearchCriteria> params){
        this.params = params;
    }

    public Specification<T> build(){
        if(params.isEmpty())
            return null;

        Specification<T> result = new GenericSpecification<>(params.get(0));

        for(int i= 0; i<params.size(); i++){
            result = result.and(new GenericSpecification<>(params.get(i)));
        }
        return result
                ;
    }

}
