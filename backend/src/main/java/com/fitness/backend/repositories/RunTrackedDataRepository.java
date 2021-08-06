package com.fitness.backend.repositories;

import com.fitness.backend.models.RunTrackedInfo;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RunTrackedDataRepository extends JpaRepository<RunTrackedInfo, Integer> {
    List<RunTrackedInfo> findAllByUserID(int userID);

    List<RunTrackedInfo> findAllByDietId(String dietId);
}
