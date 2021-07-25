package com.fitness.backend.repositories;

import com.fitness.backend.models.RunTrackedInfo;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RunTrackedDataRepository extends JpaRepository<RunTrackedInfo, Integer> {
}
