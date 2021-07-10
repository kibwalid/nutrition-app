package com.fitness.backend.controller;

import com.fitness.backend.models.ExerciseInfo;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/exercise")
public class ExerciseController {

    @PostMapping("/")
    public ExerciseInfo addExerciseInfo(@RequestBody ExerciseInfo exerciseInfo){
        return null;
    }

    @GetMapping("/{id}")
    public ExerciseInfo getExerciseInfo(@PathVariable int id){
        return null;
    }

    @GetMapping("/all/{userID}")
    public List<ExerciseInfo> getAllExerciseInfoOfUser(@PathVariable int userID){
        return null;
    }

    @PutMapping("/{id}")
    public ExerciseInfo editExerciseInfo(@PathVariable int id){
        return null;
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Map<String, String>> deleteExerciseInfo(@PathVariable int id){
        return null;
    }


}
