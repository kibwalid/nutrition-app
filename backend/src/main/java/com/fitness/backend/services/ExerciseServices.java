package com.fitness.backend.services;

import com.fitness.backend.exceptions.AppException;
import com.fitness.backend.models.DietPlan;
import com.fitness.backend.models.ExerciseInfo;
import com.fitness.backend.models.RunTrackedInfo;
import com.fitness.backend.repositories.ExerciseInfoRepository;
import com.fitness.backend.repositories.RunTrackedDataRepository;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
@Transactional
public class ExerciseServices {

    private final ExerciseInfoRepository exerciseInfoRepository;
    private final RunTrackedDataRepository runTrackedDataRepository;

    public ExerciseServices(ExerciseInfoRepository exerciseInfoRepository, RunTrackedDataRepository runTrackedDataRepository) {
        this.exerciseInfoRepository = exerciseInfoRepository;
        this.runTrackedDataRepository = runTrackedDataRepository;
    }

    public ExerciseInfo addExerciseInfo(ExerciseInfo exerciseInfo){
        try{
            return exerciseInfoRepository.saveAndFlush(exerciseInfo);
        } catch (Exception e){
            throw new AppException("Server Error: Cannot upload exercise info to database!", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    public ExerciseInfo editExerciseInfo(ExerciseInfo exerciseInfo){
        return null;
    }

    public ExerciseInfo getExerciseInfo(int id){
        Optional<ExerciseInfo> exerciseInfo = exerciseInfoRepository.findById(id);
        if(exerciseInfo.isEmpty()){
            throw new AppException("Exercise with that id does not exist in our database!", HttpStatus.NOT_FOUND);
        }
        return exerciseInfo.get();
    }

    public List<ExerciseInfo> getAllExerciseInfoOfUser(int userID){
        try{
            return exerciseInfoRepository.findAllByUserID(userID);
        } catch (Exception e){
            throw new AppException("Server error: Cannot get exercise info of user", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    public Map<String, String> deleteExerciseInfo(int id){
        try{
            exerciseInfoRepository.deleteById(id);
            Map<String, String> map = new HashMap<>();
            map.put("message", "Exercise has been deleted");
            return map;
        } catch (Exception e){
            throw new AppException("Server Error: Cannot delete exercise with that ID", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    public RunTrackedInfo addRunningTrackedData(RunTrackedInfo runTrackedInfo) {
        try {
            return runTrackedDataRepository.saveAndFlush(runTrackedInfo);
        } catch (Exception e){
            throw new AppException("Server Error: Cannot add running tracked data", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    public List<RunTrackedInfo> getAllRunTrackedData(int userID) {
        try {
            return runTrackedDataRepository.findAllByUserID(userID);
        } catch (Exception e){
            throw new AppException("Server Error: Cannot get tracked data", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    public RunTrackedInfo getSingleTrackedRun(int id) {
        try{
            Optional<RunTrackedInfo> runTrackedInfo = runTrackedDataRepository.findById(id);
            if(runTrackedInfo.isEmpty()){
                throw new AppException("Tracked Record with this id does not exist", HttpStatus.NOT_FOUND);
            }
            return runTrackedInfo.get();
        } catch (Exception e){
            throw new AppException("Server Error: Cannot get tracked data", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    public List<ExerciseInfo> getAllExerciseOfDiet(String dietId) {
        try{
            return exerciseInfoRepository.findAllByDietId(dietId);
        } catch (Exception e){
            throw new AppException("Server Error: Cannot get any exercise from database", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    public List<RunTrackedInfo> getAllRunningDataOfDiet(String dietId) {
        try{
            return runTrackedDataRepository.findAllByDietId(dietId);
        } catch (Exception e){
            throw new AppException("Server Error: Cannot get any exercise from database", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
