package com.salesianos.socialrides.validation.annotation;

import com.salesianos.socialrides.validation.validator.UniqueUsernameValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

@Target({ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Constraint(validatedBy = UniqueUsernameValidator.class)
@Documented
public @interface UniqueUsername {

    String message() default "The username provided is already in use";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

}
