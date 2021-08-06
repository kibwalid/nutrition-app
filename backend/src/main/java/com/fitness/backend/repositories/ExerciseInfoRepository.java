package com.fitness.backend.repositories;

import com.fitness.backend.models.ExerciseInfo;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ExerciseInfoRepository extends JpaRepository<ExerciseInfo, Integer> {
    List<ExerciseInfo> findAllByUserID(int userID);

    List<ExerciseInfo> findAllByDietId(String dietId);
}
