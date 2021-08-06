package com.fitness.backend.controller;

import com.fitness.backend.models.FoodIntake;
import com.fitness.backend.services.FoodIntakeServices;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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
    
    @GetMapping("/all/{dietId}")
    public List<FoodIntake> getAllFoodIntakeOfDiet(@PathVariable String dietId){
        return foodIntakeServices.getAllFoodIntakeOfDiet(dietId);
    }
}
