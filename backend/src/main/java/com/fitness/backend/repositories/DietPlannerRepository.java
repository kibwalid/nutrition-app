package com.fitness.backend.repositories;

import com.fitness.backend.models.DietPlan;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface DietPlannerRepository extends JpaRepository<DietPlan, Integer> {
    List<DietPlan> findAllByUserIdAndStatus(int userID, int id);
}
