package com.fitness.backend.services;

import com.fitness.backend.exceptions.AppException;
import com.fitness.backend.models.DietPlan;
import com.fitness.backend.repositories.DietPlannerRepository;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

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
            throw new AppException("There are no active diet plan!", HttpStatus.NOT_FOUND);
        }
        return dietPlanList.get(0);
    }
}
