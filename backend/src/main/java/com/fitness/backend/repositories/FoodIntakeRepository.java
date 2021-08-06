package com.fitness.backend.repositories;

import com.fitness.backend.models.FoodIntake;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FoodIntakeRepository extends JpaRepository<FoodIntake, Integer> {
}
