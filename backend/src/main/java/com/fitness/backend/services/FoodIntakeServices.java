package com.fitness.backend.services;

import com.fitness.backend.exceptions.AppException;
import com.fitness.backend.models.FoodIntake;
import com.fitness.backend.repositories.FoodIntakeRepository;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@Transactional
public class FoodIntakeServices {

    private final FoodIntakeRepository foodIntakeRepository;

    public FoodIntakeServices(FoodIntakeRepository foodIntakeRepository) {
        this.foodIntakeRepository = foodIntakeRepository;
    }


    public FoodIntake addFoodIntake(FoodIntake foodIntake) {
        try{
            return foodIntakeRepository.saveAndFlush(foodIntake);
        } catch (Exception e) {
            throw new AppException("Server Error: Cannot add Food Intake", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
