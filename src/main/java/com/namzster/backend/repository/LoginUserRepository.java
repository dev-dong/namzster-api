package com.namzster.backend.repository;

import com.namzster.backend.entity.LoginUser;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface LoginUserRepository extends JpaRepository<LoginUser, String> {
    Optional<LoginUser> findByUserIdAndUserPasswd(String userId, String userPasswd);
}