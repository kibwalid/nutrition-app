package com.fitness.backend.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
public class DietPlan {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private String startDate;
    private String endDate;
    private double weightNow;
    private double weightTarget;
    private double caloriePerDay;
    private String dietId;
    private int status; // 1 = active, 0 inactive
    private int userId;
}
