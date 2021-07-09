package com.fitness.backend.repositories;

import com.fitness.backend.models.UserLogin;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserLoginRepository extends JpaRepository<UserLogin, Integer> {
    boolean existsByUsername(String username);

    UserLogin findByUsername(String username);
}
