package com.salesianos.socialrides.security;

import com.salesianos.socialrides.security.errorhandling.JwtAccessDeniedHandler;
import com.salesianos.socialrides.security.errorhandling.JwtAuthenticationEntryPoint;
import com.salesianos.socialrides.security.jwt.access.JwtAuthenticationFilter;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.authentication.logout.LogoutHandler;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
@RequiredArgsConstructor
public class SecurityConfig {

    private final UserDetailsService userDetailsService;

    private final PasswordEncoder passwordEncoder;

    private final JwtAccessDeniedHandler jwtAccessDeniedHandler;

    private final JwtAuthenticationEntryPoint jwtAuthenticationEntryPoint;
    private final JwtAuthenticationFilter jwtAuthenticationFilter;

    private final LogoutHandler logoutHandler;

    private final AuthenticationProvider authenticationProvider;

    @Bean
    public AuthenticationManager authenticationManager(HttpSecurity http) throws Exception {
        AuthenticationManagerBuilder authenticationManagerBuilder = http.getSharedObject(AuthenticationManagerBuilder.class);
        return authenticationManagerBuilder.authenticationProvider(authenticationProvider()).build();
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();

        authenticationProvider.setUserDetailsService(userDetailsService);
        authenticationProvider.setPasswordEncoder(passwordEncoder);
        authenticationProvider.setHideUserNotFoundExceptions(false);

        return authenticationProvider;

    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws  Exception {

        http
                .cors(Customizer.withDefaults())
                .csrf().disable()
                    .exceptionHandling()
                        .authenticationEntryPoint(jwtAuthenticationEntryPoint)
                        .accessDeniedHandler(jwtAccessDeniedHandler)
                    .and()
                        .sessionManagement()
                                .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                    .and()
                        .authorizeRequests()
                        .antMatchers("/post/**", "/user/**").permitAll()
                        .antMatchers("/auth/**").hasRole("ADMIN")
                        .antMatchers("/auth/register/admin").hasRole("ADMIN")
                        .anyRequest().authenticated()
                    .and()
                        .authenticationProvider(authenticationProvider)
                        .addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class)
                        .logout()
                        .logoutUrl("/auth/logOut")
                        .addLogoutHandler(logoutHandler)
                        .logoutSuccessHandler(
                                (request, response, authentication) -> SecurityContextHolder.clearContext()
                        );

        http.addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class);
        http.headers().frameOptions().disable();

        return http.build();
    }


    @Bean
    public WebSecurityCustomizer webSecurityCustomizer() {
        return (web -> web.ignoring().antMatchers("/h2-console/**", "/auth/register", "/auth/login", "/refreshtoken", "/swagger-ui/**", "/v3/api-docs/**", "/download/**"));
    }
}
