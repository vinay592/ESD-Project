package com.example.erp_backend.security;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import org.springframework.stereotype.Component;

import java.util.Collections;

@Component
public class GoogleValidator {

    private final GoogleIdTokenVerifier verifier;

    public GoogleValidator() throws Exception {
        verifier = new GoogleIdTokenVerifier.Builder(
                GoogleNetHttpTransport.newTrustedTransport(),
                GsonFactory.getDefaultInstance()
        )
                .setAudience(Collections.singletonList("207867408214-n2rba2hdeaq2sl1qua9cio64najrlfis.apps.googleusercontent.com"))
                .build();
    }

    public GoogleIdToken.Payload verifyToken(String token) {
        try {
            GoogleIdToken googleIdToken = verifier.verify(token);
            if (googleIdToken == null) throw new RuntimeException("Invalid Google token");
            return googleIdToken.getPayload();
        } catch (Exception e) {
            throw new RuntimeException("Google token verification failed");
        }
    }
}
