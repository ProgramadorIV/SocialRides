package com.salesianos.socialrides.security.jwt.access;


import com.salesianos.socialrides.model.user.User;
import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import io.jsonwebtoken.security.SignatureException;
import lombok.extern.java.Log;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import javax.crypto.SecretKey;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.UUID;

@Log
@Service
public class JwtProvider {

    public static final String TOKEN_TYPE ="JWT";
    public static final String TOKEN_HEADER = "Authorization";
    public static final String TOKEN_PREFIX = "Bearer";


    @Value("${jwt.secret}")
    private String jwtSecret;

    @Value("${jwt.duration}")
    //private int lifeInDays; Para dev pongo la duración en minutos
    private int lifeInMinutes;

    private JwtParser jwtParser;

    private SecretKey secretKey;

    @PostConstruct
    public void init() {

        secretKey = Keys.hmacShaKeyFor(jwtSecret.getBytes());

        jwtParser = Jwts.parserBuilder()
                .setSigningKey(secretKey)
                .build();
    }

    public String generateToken(Authentication authentication){

        User user = (User) authentication.getPrincipal();
        return generateToken(user);
    }

    public String generateToken(User user) {

        Date tokenExpirationDateTime =
                Date.from(
                        LocalDateTime
                                .now()
                                //.plusDays(lifeInDays)
                                .plusMinutes(lifeInMinutes)
                                .atZone(ZoneId.systemDefault())
                                .toInstant()
                );

        return Jwts.builder()
                .setHeaderParam("typ", TOKEN_TYPE)
                .setSubject(user.getId().toString())
                .setIssuedAt(new Date())
                .setExpiration(tokenExpirationDateTime)
                .signWith(secretKey)
                .compact();

    }

    public UUID getUserIdFromToken(String token){
        return UUID.fromString(
                jwtParser.parseClaimsJws(token).getBody().getSubject()
        );
    }

    public boolean validateToken(String token) {

        try {
            jwtParser.parseClaimsJws(token);
            return true;
        }
        catch (SignatureException | MalformedJwtException | ExpiredJwtException | UnsupportedJwtException | IllegalArgumentException ex) {
            log.info("Error con el token: " + ex.getMessage());
        }
        return false; //Este return esta comentado pero no se porque
    }
}
