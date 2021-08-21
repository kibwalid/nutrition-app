package com.fitness.backend.services;

import com.fitness.backend.exceptions.AppException;
import com.fitness.backend.models.UserInfo;
import com.fitness.backend.models.UserLogin;
import com.fitness.backend.repositories.UserInfoRepository;
import com.fitness.backend.repositories.UserLoginRepository;
import com.fitness.backend.security.JwtTokenProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Service
@Transactional
public class UserServices {

    private final UserLoginRepository userLoginRepository;
    private final UserInfoRepository userInfoRepository;

    private final JwtTokenProvider jwtTokenProvider;

    public UserServices(UserLoginRepository userLoginRepository, UserInfoRepository userInfoRepository, JwtTokenProvider jwtTokenProvider) {
        this.userLoginRepository = userLoginRepository;
        this.userInfoRepository = userInfoRepository;
        this.jwtTokenProvider = jwtTokenProvider;
    }

    public Map<String, String> registerUser(UserInfo userInfo) {
        if(!(userLoginRepository.existsByUsername(userInfo.getUserLogin().getUsername()))){
            String hashedPassword = BCrypt.hashpw(userInfo.getUserLogin().getPassword(), BCrypt.gensalt(10));
            userInfo.getUserLogin().setPassword(hashedPassword);
            UserInfo user = userInfoRepository.saveAndFlush(userInfo);
            return jwtTokenProvider.createToken(user);
        }else {
            throw new AppException("Email/Username is already in use", HttpStatus.UNPROCESSABLE_ENTITY);
        }
    }


    public Map<String, String> validateUser(UserLogin userLogin) {
        try{
            UserInfo userInfo = userInfoRepository.findByUsername(userLogin.getUsername());
            if(!BCrypt.checkpw(userLogin.getPassword(), userInfo.getUserLogin().getPassword())){
                throw new AppException("Invalid username/password, please try again!", HttpStatus.UNPROCESSABLE_ENTITY);
            }
            return jwtTokenProvider.createToken(userInfo);
        } catch (Exception e) {
            throw new AppException("Invalid username/password, please try again!", HttpStatus.UNPROCESSABLE_ENTITY);
        }
    }

    public UserInfo getUserInfo(int id) {
        Optional<UserInfo> userInfo = userInfoRepository.findById(id);
        if (userInfo.isPresent()){
            return userInfo.get();
        }
        throw new AppException("User with this id does not exist", HttpStatus.NOT_FOUND);
    }

    public UserInfo updateUserInfo(UserInfo userInfo){
        Optional<UserInfo> updateUserInfo = userInfoRepository.findById(userInfo.getId());
        if(updateUserInfo.isPresent()){
            updateUserInfo.get().setFirstName(userInfo.getFirstName());
            updateUserInfo.get().setLastName(userInfo.getLastName());
            updateUserInfo.get().setUserHeight(userInfo.getUserHeight());
            updateUserInfo.get().setUserWeight(userInfo.getUserWeight());
            try {
                return userInfoRepository.saveAndFlush(updateUserInfo.get());
            }catch (Exception e){
                throw new AppException("Server Error: Unable to update user data!", HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }
        throw new AppException("user with this id does not exist", HttpStatus.NOT_FOUND);
    }

    public Map<String, String> changePassword(Map<String, String> changePassInfo){
        return null;
    }

    public Map<String, String> refreshToken(int userID){
        try{
            Optional<UserInfo> userInfo = userInfoRepository.findById(userID);
            if(userInfo.isEmpty()){
                throw new AppException("User does not exist in our database", HttpStatus.NOT_FOUND);
            }
            return jwtTokenProvider.createToken(userInfo.get());
        }catch (AuthenticationServiceException e){
            throw new AppException("Invalid username/password, Please try again.", HttpStatus.UNPROCESSABLE_ENTITY);
        }
    }

    public Map<String, String> deleteUser(int id) {
        try {
            userInfoRepository.deleteById(id);
            Map<String, String> map = new HashMap<>();
            map.put("message", "User has been deleted");
            return map;
        } catch (Exception e){
            throw new AppException("Server Error: Unable to delete data", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
