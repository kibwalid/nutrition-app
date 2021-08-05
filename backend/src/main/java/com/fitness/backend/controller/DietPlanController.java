package com.fitness.backend.controller;

import com.fitness.backend.services.DietPlanServices;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/diet")
public class DietPlanController {

    private final DietPlanServices dietPlanServices;

    public DietPlanController(DietPlanServices dietPlanServices) {
        this.dietPlanServices = dietPlanServices;
    }
}
