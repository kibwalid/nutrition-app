package com.fitness.backend.controller;

import com.fitness.backend.models.DietPlan;
import com.fitness.backend.services.DietPlanServices;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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

    @PutMapping("/end")
    public DietPlan endDietPlan(@RequestBody DietPlan dietPlan){
        return dietPlanServices.endDietPlan(dietPlan);
    }

    @GetMapping("/active/{userID}")
    public DietPlan getActiveDietPlan(@PathVariable int userID){
        return dietPlanServices.getActiveDietPlan(userID);
    }


}
