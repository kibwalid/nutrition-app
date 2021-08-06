package com.fitness.backend.controller;

import com.fitness.backend.models.WaterIntake;
import com.fitness.backend.services.WaterIntakeServices;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("api/intake")
public class WaterIntakeController {

    private final WaterIntakeServices waterIntakeServices;

    public WaterIntakeController(WaterIntakeServices waterIntakeServices) {
        this.waterIntakeServices = waterIntakeServices;
    }

    @PostMapping("/check")
    public List<WaterIntake> checkWaterIntake(@RequestBody WaterIntake waterIntake){
        return waterIntakeServices.checkWaterIntake(waterIntake);
    }

    @PostMapping("/add")
    public WaterIntake addWaterIntake(@RequestBody WaterIntake waterIntake){
        return waterIntakeServices.addWaterIntake(waterIntake);
    }

    @GetMapping("/all/{userId}")
    public List<WaterIntake> getAllWaterIntake(@PathVariable int userId){
        return waterIntakeServices.getAllWaterIntake(userId);
    }

    @GetMapping("/all/day/{dayId}")
    public List<WaterIntake> getAllWaterIntakeOfDay(@PathVariable String dayId){
        return waterIntakeServices.getAllWaterIntakeOfDay(dayId);
    }
}
