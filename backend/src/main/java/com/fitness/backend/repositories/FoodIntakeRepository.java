package com.fitness.backend.repositories;

import com.fitness.backend.models.FoodIntake;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FoodIntakeRepository extends JpaRepository<FoodIntake, Integer> {
    List<FoodIntake> findAllByDietId(String dietId);
}
