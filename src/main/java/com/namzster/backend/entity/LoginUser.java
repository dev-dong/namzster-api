package com.namzster.backend.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "login")
@Getter
@Setter
@NoArgsConstructor
public class LoginUser {

    @Id
    @Column(name = "user_id", length = 32)
    private String userId;

    @Column(name = "user_passwd", length = 32)
    private String userPasswd;

    @Column(name = "user_type", length = 10)
    private String userType;

}
