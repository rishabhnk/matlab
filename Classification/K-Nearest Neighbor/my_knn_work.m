%% --------------- Importing the dataset -------------------------
% ---------------------------- Code ---------------------------
data = readtable('C:\dev\matlabCode\Classification\K-Nearest Neighbor\Social_Network_Ads.csv');



%________________________________________________________________
%________________________________________________________________

%%---------------Data Preprocessing -----------------------------


%% -------------- Feature Scalling -------------------------------

% -------------- Method 1: Standardization ----------------------
% ---------------------------- Code -----------------------------

stand_age = (data.Age - mean(data.Age))/std(data.Age);
data.Age = stand_age; 

stand_estimted_salary = (data.EstimatedSalary - mean(data.EstimatedSalary))/std(data.EstimatedSalary);
data.EstimatedSalary = stand_estimted_salary; 

plot(data.Age) 
%________________________________________________________________
%________________________________________________________________

%%%%---------------Classifying Data  -----------------------------
%% -------------- Building Classifier ----------------------------
% ---------------------------- Code ---------------------------

classification_model = fitcknn(data,'Purchased~Age+EstimatedSalary');




cv = cvpartition(classification_model.NumObservations, 'HoldOut', 0.2);
cross_validated_model = crossval(classification_model, 'cvpartition', cv);

Predictions = predict(cross_validated_model.Trained{1},data(test(cv),1:end-1));


Results = confusionmat(cross_validated_model.Y(test(cv)), Predictions);






