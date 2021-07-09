package com.fitness.backend.controller;

import com.fitness.backend.models.UserInfo;
import com.fitness.backend.models.UserLogin;
import com.fitness.backend.services.UserServices;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("api/user")
public class UserController {

    private final UserServices userServices;

    public UserController(UserServices userServices){
        this.userServices = userServices;
    }

    @PostMapping("/register")
    public ResponseEntity<Map<String, String>> registerUser(@RequestBody UserInfo userInfo){
        return new ResponseEntity<>(userServices.registerUser(userInfo), HttpStatus.OK);
    }

    @PostMapping("/login")
    public ResponseEntity<Map<String, String>> login(@RequestBody UserLogin userLogin){
        return new ResponseEntity<>(userServices.validateUser(userLogin), HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public UserInfo getUserInfo(@PathVariable int id) {
        return userServices.getUserInfo(id);
    }

    @GetMapping("/refresh/{id}")
    public ResponseEntity<Map<String, String>> refreshToken(@PathVariable int id){
        return new ResponseEntity<>(userServices.refreshToken(id), HttpStatus.OK);
    }


}
