package com.fitness.backend.services;

import com.fitness.backend.exceptions.AppException;
import com.fitness.backend.models.WaterIntake;
import com.fitness.backend.repositories.WaterIntakeRepository;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class WaterIntakeServices {

    private final WaterIntakeRepository waterIntakeRepository;

    public WaterIntakeServices(WaterIntakeRepository waterIntakeRepository) {
        this.waterIntakeRepository = waterIntakeRepository;
    }


    public List<WaterIntake> checkWaterIntake(WaterIntake intakeData) {
        List<WaterIntake> waterIntake = waterIntakeRepository.findAllByWaterIntakeIdAndId(intakeData.getWaterIntakeId(),
                intakeData.getUserId());
        if(waterIntake.isEmpty()){
            return List.of(waterIntakeRepository.saveAndFlush(intakeData));
        }
        return waterIntake;
    }

    public WaterIntake addWaterIntake(WaterIntake waterIntake) {
        try{
            return waterIntakeRepository.saveAndFlush(waterIntake);
        } catch (Exception e){
            throw new AppException("Server Error: Cannot add water intake", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
