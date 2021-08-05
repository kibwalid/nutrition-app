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
public class WaterIntake {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private String liquidType;
    private double amount;
    private int userId;
    private String waterIntakeId;
}
