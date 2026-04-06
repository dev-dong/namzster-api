package com.namzster.backend.service;

import com.namzster.backend.dto.LoginRequest;
import com.namzster.backend.dto.LoginResponse;
import com.namzster.backend.repository.LoginUserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class LoginService {
    private final LoginUserRepository repo;

    public LoginResponse login(LoginRequest request) {
        return repo.findByUserIdAndUserPasswd(request.getUsername(), request.getPassword())
                .map(u -> new LoginResponse(true, u.getUserType(), "/" + u.getUserType()))
                .orElse(new LoginResponse(false, "", "/"));
    }
}
