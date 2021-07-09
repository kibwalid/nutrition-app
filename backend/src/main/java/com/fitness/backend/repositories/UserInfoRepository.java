package com.fitness.backend.repositories;

import com.fitness.backend.models.UserInfo;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserInfoRepository extends JpaRepository<UserInfo, Integer> {
    boolean existsByEmail(String email);

    UserInfo findByUsername(String username);
}
