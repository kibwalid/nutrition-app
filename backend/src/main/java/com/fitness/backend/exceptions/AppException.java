package com.fitness.backend.exceptions;

import org.springframework.http.HttpStatus;

public class AppException extends RuntimeException{

    private final String message;
    private final HttpStatus httpStatus;

    public AppException(String message, HttpStatus httpStatus){
        this.message = message;
        this.httpStatus = httpStatus;
    }

    @Override
    public String getMessage() {
        return message;
    }

    public HttpStatus getHttpStatus() {
        return httpStatus;
    }

}
