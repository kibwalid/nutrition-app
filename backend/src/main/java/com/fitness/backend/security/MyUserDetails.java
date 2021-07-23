package com.fitness.backend.security;


import com.fitness.backend.models.UserLogin;
import com.fitness.backend.repositories.UserLoginRepository;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class MyUserDetails implements UserDetailsService {

    private final UserLoginRepository userLoginRepository;

    public MyUserDetails(UserLoginRepository userLoginRepository){
        this.userLoginRepository = userLoginRepository;
    }

    @Override
    public org.springframework.security.core.userdetails.UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        final UserLogin user = userLoginRepository.findByUsername(username);

        if (user == null) {
            throw new UsernameNotFoundException("User '" + username + "' not found");
        }

        return org.springframework.security.core.userdetails.User//
                .withUsername(username)//
                .password(user.getPassword())//
                .authorities(user.getRoles())//
                .accountExpired(false)//
                .accountLocked(false)//
                .credentialsExpired(false)//
                .disabled(false)//
                .build();
    }
}
