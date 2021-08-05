package com.fitness.backend.repositories;

import com.fitness.backend.models.DietPlan;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DietPlannerRepository extends JpaRepository<DietPlan, Integer> {
}
