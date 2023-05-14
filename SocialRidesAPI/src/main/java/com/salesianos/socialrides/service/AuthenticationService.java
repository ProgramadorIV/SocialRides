package com.salesianos.socialrides.service;

import com.salesianos.socialrides.model.user.User;
import com.salesianos.socialrides.model.user.dto.JwtUserResponse;
import com.salesianos.socialrides.model.user.dto.LoginRequest;
import com.salesianos.socialrides.model.user.dto.UserResponse;
import com.salesianos.socialrides.security.jwt.access.JwtProvider;
import com.salesianos.socialrides.security.jwt.refresh.RefreshToken;
import com.salesianos.socialrides.security.jwt.refresh.RefreshTokenException;
import com.salesianos.socialrides.security.jwt.refresh.RefreshTokenRequest;
import com.salesianos.socialrides.security.jwt.refresh.RefreshTokenService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthenticationService {

    private final AuthenticationManager authManager;
    private final JwtProvider jwtProvider;
    private final RefreshTokenService refreshTokenService;

    public UserResponse login(LoginRequest loginRequest){
        Authentication authentication =
                authManager.authenticate(
                        new UsernamePasswordAuthenticationToken(
                                loginRequest.getUsername(),
                                loginRequest.getPassword()
                        )
                );
        SecurityContextHolder.getContext().setAuthentication(authentication);
        String token = jwtProvider.generateToken(authentication);
        User user = (User) authentication.getPrincipal();

        refreshTokenService.deleteByUser(user);
        RefreshToken refreshToken = refreshTokenService.createRefreshToken(user);

        return UserResponse.toLoggedUser(user, token, refreshToken.getToken());
    }

    public JwtUserResponse refreshToken(RefreshTokenRequest refreshTokenRequest){
        String refreshedToken = refreshTokenRequest.getRefreshedToken();

        return refreshTokenService.findByToken(refreshedToken)
                .map(refreshTokenService::verify)
                .map(RefreshToken::getUser)
                .map(user -> {
                    String token = jwtProvider.generateToken(user);
                    refreshTokenService.deleteByUser(user);
                    RefreshToken refreshedTokenV2 = refreshTokenService.createRefreshToken(user);
                    return JwtUserResponse.builder()
                            .token(token)
                            .refreshedToken(refreshedTokenV2.getToken())
                            .build();

                }).orElseThrow(() -> new RefreshTokenException("Refresh token could not be found"));
    }
}
