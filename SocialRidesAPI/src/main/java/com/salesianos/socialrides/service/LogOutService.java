package com.salesianos.socialrides.service;

import com.salesianos.socialrides.security.jwt.refresh.RefreshToken;
import com.salesianos.socialrides.security.jwt.refresh.RefreshTokenService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.LogoutHandler;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.Instant;

@Service
@RequiredArgsConstructor
public class LogOutService implements LogoutHandler {

    private final RefreshTokenService refreshTokenService;

    @Override
    public void logout(HttpServletRequest request, HttpServletResponse response, Authentication authentication) {
        final String header = request.getHeader("Authorization");
        final String jwt;
        if(header == null || !header.startsWith("Bearer "))
            return;
        jwt = header.substring(8);
        RefreshToken token = refreshTokenService.findByToken(jwt).orElseThrow();
        token.setExpireDate(Instant.now().minusMillis(1));

        refreshTokenService.save(token);
        SecurityContextHolder.clearContext();
    }
}
