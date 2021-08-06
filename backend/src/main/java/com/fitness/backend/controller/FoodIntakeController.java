package com.fitness.backend.controller;

import com.fitness.backend.models.FoodIntake;
import com.fitness.backend.services.FoodIntakeServices;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/food")
public class FoodIntakeController {

    private final FoodIntakeServices foodIntakeServices;

    public FoodIntakeController(FoodIntakeServices foodIntakeServices) {
        this.foodIntakeServices = foodIntakeServices;
    }

    @PostMapping("/")
    public FoodIntake addFoodIntake(@RequestBody FoodIntake foodIntake){
        return foodIntakeServices.addFoodIntake(foodIntake);
    }
}
