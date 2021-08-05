package com.fitness.backend.controller;

import com.fitness.backend.models.DietPlan;
import com.fitness.backend.services.DietPlanServices;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/diet")
public class DietPlanController {

    private final DietPlanServices dietPlanServices;

    public DietPlanController(DietPlanServices dietPlanServices) {
        this.dietPlanServices = dietPlanServices;
    }

    @GetMapping("/{userID}")
    public DietPlan getDietPlanOfUser(@PathVariable int userID){
        return dietPlanServices.getDietPlanOfUser(userID);
    }

    @PostMapping("/")
    public DietPlan addDietPlan(@RequestBody DietPlan dietPlan){
        return dietPlanServices.addDietPlan(dietPlan);
    }

    @GetMapping("/active/{userID}")
    public DietPlan getActiveDietPlan(@PathVariable int userID){
        return dietPlanServices.getActiveDietPlan(userID);
    }
}
