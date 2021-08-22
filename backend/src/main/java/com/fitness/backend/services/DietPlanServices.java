package com.fitness.backend.services;

import com.fitness.backend.exceptions.AppException;
import com.fitness.backend.models.DietPlan;
import com.fitness.backend.repositories.DietPlannerRepository;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class DietPlanServices {

    private final DietPlannerRepository dietPlannerRepository;

    public DietPlanServices(DietPlannerRepository dietPlannerRepository) {
        this.dietPlannerRepository = dietPlannerRepository;
    }

    public DietPlan getDietPlanOfUser(int userID) {
        return null;
    }

    public DietPlan addDietPlan(DietPlan dietPlan) {
        try {
            return dietPlannerRepository.saveAndFlush(dietPlan);
        } catch (Exception e){
            throw new AppException("Server Error: Cannot add diet plan!", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    public DietPlan getActiveDietPlan(int userID) {
        List<DietPlan> dietPlanList = dietPlannerRepository.findAllByUserIdAndStatus(userID, 1);
        System.out.println(dietPlanList);
        if(dietPlanList.isEmpty()){
            return null;
        }
        return dietPlanList.get(0);
    }


    public DietPlan endDietPlan(DietPlan dietPlan) {
        Optional<DietPlan> dietPlanFromDB = dietPlannerRepository.findById(dietPlan.getId());
        if(dietPlanFromDB.isEmpty()){
            throw new AppException("Cannot find diet", HttpStatus.NOT_FOUND);
        }
        try{
            dietPlanFromDB.get().setStatus(0);
            return dietPlannerRepository.save(dietPlanFromDB.get());
        } catch (Exception e){
            throw new AppException("Server Error", HttpStatus.UNPROCESSABLE_ENTITY);
        }
    }
}
