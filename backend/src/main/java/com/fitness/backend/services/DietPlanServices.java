package com.fitness.backend.services;

import com.fitness.backend.repositories.DietPlannerRepository;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;

@Service
@Transactional
public class DietPlanServices {

    private final DietPlannerRepository dietPlannerRepository;

    public DietPlanServices(DietPlannerRepository dietPlannerRepository) {
        this.dietPlannerRepository = dietPlannerRepository;
    }
}
