package com.fitness.backend.repositories;

import com.fitness.backend.models.WaterIntake;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface WaterIntakeRepository extends JpaRepository<WaterIntake, Integer> {

    List<WaterIntake> findAllByWaterIntakeIdAndId(String waterIntakeId, int id);

    List<WaterIntake> findAllByUserId(int userId);

    List<WaterIntake> findAllByWaterIntakeId(String dayId);
}
