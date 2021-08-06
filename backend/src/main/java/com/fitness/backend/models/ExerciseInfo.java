package com.fitness.backend.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "exercise_info")
public class ExerciseInfo {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;
    private int userID;
    private String exerciseName;
    private double caloriesBurned;
    private int counter;
    private int timesDone;
    private String date;
    private String dietId;
}
