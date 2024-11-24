import 'package:flutter/material.dart';

class DiseasesForms extends StatefulWidget {
  final bool isHighBlood;
  final bool isLowBlood;
  final bool isEpilepsy;
  final bool isAIDSorHIV;
  final bool isSTD;
  final bool isUlcers;
  final bool isFaintingSeizure;
  final bool isRapidWeightLoss;
  final bool isRadiationTherapy;

  final bool isJointReplacement;
  final bool isHeartSurgery;
  final bool isHeartAttack;
  final bool isThyroidProblem;
  final bool isHeartDisease;
  final bool isHeartMurmur;
  final bool isLiverDisease;
  final bool isRheumaticFever;
  final bool isHayFever;

  final bool isRespiratoryProblems;
  final bool isJaundice;
  final bool isTuberculosis;
  final bool isSwollenAnkle;
  final bool isKidneyDisease;
  final bool isDiabetes;
  final bool isChestPain;
  final bool isStroke;
  final bool isCancer;

  final bool isAnemia;
  final bool isAngina;
  final bool isAsthma;
  final bool isEmphysema;
  final bool isBleedingProblem;
  final bool isBloodDisease;
  final bool isHeadInjuries;
  final bool isArthritis;
  final bool othersDisease;
  final Function(
    bool, bool, bool, bool, bool, bool, bool, bool, bool, bool, 
    bool, bool, bool, bool, bool, bool, bool, bool, bool, bool, 
    bool, bool, bool, bool, bool, bool, bool, bool, bool, bool,
    bool, bool, bool, bool, bool
  ) onConditionsChanged;

  const DiseasesForms({
    super.key, 
    required GlobalKey<FormState> formKey,
    required this.isHighBlood,
    required this.isLowBlood,
    required this.isEpilepsy,
    required this.isAIDSorHIV,
    required this.isSTD,
    required this.isUlcers,
    required this.isFaintingSeizure,
    required this.isRapidWeightLoss,
    required this.isRadiationTherapy,
    required this.isJointReplacement,
    required this.isHeartSurgery,
    required this.isHeartAttack,
    required this.isThyroidProblem,
    required this.isHeartDisease,
    required this.isHeartMurmur,
    required this.isLiverDisease,
    required this.isRheumaticFever,
    required this.isHayFever,
    required this.isRespiratoryProblems,
    required this.isJaundice,
    required this.isTuberculosis,
    required this.isSwollenAnkle,
    required this.isKidneyDisease,
    required this.isDiabetes,
    required this.isChestPain,
    required this.isStroke,
    required this.isCancer,
    required this.isAnemia,
    required this.isAngina,
    required this.isAsthma,
    required this.isEmphysema,
    required this.isBleedingProblem,
    required this.isBloodDisease,
    required this.isHeadInjuries,
    required this.isArthritis,  
    required this.othersDisease,
    required this.onConditionsChanged,
  });

  @override
  DiseasesFormsState createState() => DiseasesFormsState();
}

class DiseasesFormsState extends State<DiseasesForms> {
  final _diseasesFormKey = GlobalKey<FormState>();

  late bool _isHighBlood;
  late bool _isLowBlood;
  late bool _isEpilepsy;
  late bool _isAIDSorHIV;
  late bool _isSTD;
  late bool _isUlcers;
  late bool _isFaintingSeizure;
  late bool _isRapidWeightLoss;
  late bool _isRadiationTherapy;

  late bool _isJointReplacement;
  late bool _isHeartSurgery;
  late bool _isHeartAttack;
  late bool _isThyroidProblem;
  late bool _isHeartDisease;
  late bool _isHeartMurmur;
  late bool _isLiverDisease;
  late bool _isRheumaticFever;
  late bool _isHayFever;

  late bool _isRespiratoryProblems;
  late bool _isJaundice;
  late bool _isTuberculosis;
  late bool _isSwollenAnkle;
  late bool _isKidneyDisease;
  late bool _isDiabetes;
  late bool _isChestPain;
  late bool _isStroke;
  late bool _isCancer;

  late bool _isAnemia;
  late bool _isAngina;
  late bool _isAsthma;
  late bool _isEmphysema;
  late bool _isBleedingProblem;
  late bool _isBloodDisease;
  late bool _isHeadInjuries;
  late bool _isArthritis;
  late bool _othersDisease;

  void initState(){
    super.initState();
    _isHighBlood = widget.isHighBlood;
    _isLowBlood = widget.isLowBlood;
    _isEpilepsy = widget.isEpilepsy;
    _isAIDSorHIV = widget.isAIDSorHIV;
    _isSTD = widget.isSTD;
    _isUlcers = widget.isUlcers;
    _isFaintingSeizure = widget.isFaintingSeizure;
    _isRapidWeightLoss = widget.isRapidWeightLoss;
    _isRadiationTherapy = widget.isRadiationTherapy;

    _isJointReplacement = widget.isJointReplacement;
    _isHeartSurgery = widget.isHeartSurgery;
    _isHeartAttack = widget.isHeartAttack;
    _isHeartDisease = widget.isHeartDisease;
    _isHeartMurmur = widget.isHeartMurmur;
    _isThyroidProblem = widget.isThyroidProblem;
    _isLiverDisease = widget.isLiverDisease;
    _isRheumaticFever = widget.isRheumaticFever;
    _isHayFever = widget.isHayFever;

    _isRespiratoryProblems = widget.isRespiratoryProblems;
    _isJaundice = widget.isJaundice;
    _isTuberculosis = widget.isTuberculosis;
    _isSwollenAnkle = widget.isSwollenAnkle;
    _isKidneyDisease = widget.isKidneyDisease;
    _isDiabetes = widget.isDiabetes;
    _isChestPain = widget.isChestPain;
    _isStroke = widget.isStroke;
    _isCancer = widget.isCancer;

    _isAnemia = widget.isAnemia;
    _isAngina = widget.isAngina;
    _isAsthma = widget.isAsthma;
    _isEmphysema = widget.isEmphysema;
    _isBleedingProblem = widget.isBleedingProblem;
    _isBloodDisease = widget.isBloodDisease;
    _isHeadInjuries = widget.isHeadInjuries;
    _isArthritis = widget.isArthritis;
    _othersDisease = widget.othersDisease;
}

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _diseasesFormKey,
        child: Column(
          children: [
            // (Diseases fields)
            
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Diseases",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Divider(
                    height: 10,
                    color: Colors.grey[400],
                    thickness: 0.5,
                  ),
                  const SizedBox(height: 10),

                  //Diseases
                  const Row(
                    children: [
                      Text(
                            "Do you have or have you had any of the following? Check which apply",
                            style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    ),
                          ),
                    ],
                  ),
                  const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Checkbox(
                                    value: _isHighBlood,
                                    onChanged: (value) {
                                      setState(() {
                                        _isHighBlood = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("High Blood Pressure"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),
                                  Checkbox(
                                    value: _isLowBlood,
                                    onChanged: (value) {
                                      setState(() {
                                        _isLowBlood = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("Low Blood Pressure"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Checkbox(
                                    value: _isEpilepsy,
                                    onChanged: (value) {
                                      setState(() {
                                        _isEpilepsy = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("Epilepsy / Convulsions"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),
                                  Checkbox(
                                    value: _isAIDSorHIV,
                                    onChanged: (value) {
                                      setState(() {
                                        _isAIDSorHIV = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("AIDS or HIV Infection"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Checkbox(
                                      value: _isSTD,
                                      onChanged: (value) {
                                        setState(() {
                                          _isSTD = value!;
                                        });
                                        widget.onConditionsChanged(
                                          _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                          _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                          _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                          _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                          _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                          _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                          _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                          _isBloodDisease, _isHeadInjuries, _isArthritis
                                        );
                                      },
                                    ),
                                    const Text("Sexual Transmitted Disease"),
                                  ],
                                ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),
                                  Checkbox(
                                    value: _isUlcers,
                                    onChanged: (value) {
                                      setState(() {
                                        _isUlcers = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("Stomach Troubles / Ulcers"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),
                                  Checkbox(
                                    value: _isFaintingSeizure,
                                    onChanged: (value) {
                                      setState(() {
                                        _isFaintingSeizure = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("Fainting Seizure"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Checkbox(
                                      value: _isRapidWeightLoss,
                                      onChanged: (value) {
                                        setState(() {
                                          _isRapidWeightLoss = value!;
                                        });
                                        widget.onConditionsChanged(
                                          _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                          _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                          _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                          _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                          _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                          _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                          _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                          _isBloodDisease, _isHeadInjuries, _isArthritis
                                        );
                                      },
                                    ),
                                    const Text("Rapid weigth Loss"),
                                  ],
                                ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),
                                  Checkbox(
                                    value: _isRadiationTherapy,
                                    onChanged: (value) {
                                      setState(() {
                                        _isRadiationTherapy = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("Radiation Therapy"),
                                ],
                              ),
                            ),
                          ],
                        ),


                        Column(
                          children: [
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Checkbox(
                                    value: _isJointReplacement,
                                    onChanged: (value) {
                                      setState(() {
                                        _isJointReplacement = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("Joint Replacement / Implants"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),
                                  Checkbox(
                                    value: _isHeartSurgery,
                                    onChanged: (value) {
                                      setState(() {
                                        _isHeartSurgery = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("Heart Surgery"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Checkbox(
                                    value: _isHeartAttack,
                                    onChanged: (value) {
                                      setState(() {
                                        _isHeartAttack = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("Heart Attack"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),
                                  Checkbox(
                                    value: _isThyroidProblem,
                                    onChanged: (value) {
                                      setState(() {
                                        _isThyroidProblem = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("Thyroid Problem"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Checkbox(
                                      value: _isHeartDisease,
                                      onChanged: (value) {
                                        setState(() {
                                          _isHeartDisease = value!;
                                        });
                                        widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                      },
                                    ),
                                    const Text("Heart Disease"),
                                  ],
                                ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),
                                  Checkbox(
                                    value: _isHeartMurmur,
                                    onChanged: (value) {
                                      setState(() {
                                        _isHeartMurmur = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("Heart Murmur"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),
                                  Checkbox(
                                    value: _isLiverDisease,
                                    onChanged: (value) {
                                      setState(() {
                                        _isLiverDisease = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("Hepatitis / Liver Disease"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Checkbox(
                                      value: _isRheumaticFever,
                                      onChanged: (value) {
                                        setState(() {
                                          _isRheumaticFever = value!;
                                        });
                                        widget.onConditionsChanged(
                                          _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                          _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                          _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                          _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                          _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                          _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                          _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                          _isBloodDisease, _isHeadInjuries, _isArthritis
                                        );
                                      },
                                    ),
                                    const Text("Rheumatic Fever"),
                                  ],
                                ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),
                                  Checkbox(
                                    value: _isHayFever,
                                    onChanged: (value) {
                                      setState(() {
                                        _isHayFever = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("Hay Fever / Allergies"),
                                ],
                              ),
                            ),
                          ],
                        ),


                        Column(
                          children: [
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Checkbox(
                                    value: _isRespiratoryProblems,
                                    onChanged: (value) {
                                      setState(() {
                                        _isRespiratoryProblems = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("Respiratory Problems"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),
                                  Checkbox(
                                    value: _isJaundice,
                                    onChanged: (value) {
                                      setState(() {
                                        _isJaundice = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("Hepatitis / Jaundice"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Checkbox(
                                    value: _isTuberculosis,
                                    onChanged: (value) {
                                      setState(() {
                                        _isTuberculosis = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("Tuberculosis"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),
                                  Checkbox(
                                    value: _isSwollenAnkle,
                                    onChanged: (value) {
                                      setState(() {
                                        _isSwollenAnkle = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("Swollen Ankles"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Checkbox(
                                      value: _isKidneyDisease,
                                      onChanged: (value) {
                                        setState(() {
                                          _isKidneyDisease = value!;
                                        });
                                        widget.onConditionsChanged(
                                          _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                          _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                          _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                          _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                          _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                          _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                          _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                          _isBloodDisease, _isHeadInjuries, _isArthritis
                                        );
                                      },
                                    ),
                                    const Text("Kidney Disease"),
                                  ],
                                ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),
                                  Checkbox(
                                    value: _isDiabetes,
                                    onChanged: (value) {
                                      setState(() {
                                        _isDiabetes = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("Diabetes"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),
                                  Checkbox(
                                    value: _isChestPain,
                                    onChanged: (value) {
                                      setState(() {
                                        _isChestPain = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("Chest Pain"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Checkbox(
                                      value: _isStroke,
                                      onChanged: (value) {
                                        setState(() {
                                          _isStroke = value!;
                                        });
                                        widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                      },
                                    ),
                                    const Text("Stroke"),
                                  ],
                                ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),
                                  Checkbox(
                                    value: _isCancer,
                                    onChanged: (value) {
                                      setState(() {
                                        _isCancer = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("Cancer / Tumors"),
                                ],
                              ),
                            ),
                          ],
                        ),

                        
                        Column(
                          children: [
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Checkbox(
                                    value: _isAnemia,
                                    onChanged: (value) {
                                      setState(() {
                                        _isAnemia = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("Anemia"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),
                                  Checkbox(
                                    value: _isAngina,
                                    onChanged: (value) {
                                      setState(() {
                                        _isAngina = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("Angina"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Checkbox(
                                    value: _isAsthma,
                                    onChanged: (value) {
                                      setState(() {
                                        _isAsthma = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("Asthma"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),
                                  Checkbox(
                                    value: _isEmphysema,
                                    onChanged: (value) {
                                      setState(() {
                                        _isEmphysema = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("Emphysema"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Checkbox(
                                      value: _isBleedingProblem,
                                      onChanged: (value) {
                                        setState(() {
                                          _isBleedingProblem = value!;
                                        });
                                        widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                      },
                                    ),
                                    const Text("Bleeding Problems"),
                                  ],
                                ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),
                                  Checkbox(
                                    value: _isBloodDisease,
                                    onChanged: (value) {
                                      setState(() {
                                        _isBloodDisease = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("Blood Diseases"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 10),
                                  Checkbox(
                                    value: _isHeadInjuries,
                                    onChanged: (value) {
                                      setState(() {
                                        _isHeadInjuries = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("Head Injuries"),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Checkbox(
                                      value: _isArthritis,
                                      onChanged: (value) {
                                        setState(() {
                                          _isArthritis = value!;
                                        });
                                        widget.onConditionsChanged(
                                          _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                          _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                          _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isThyroidProblem, _isHeartDisease, 
                                          _isHeartMurmur, _isLiverDisease, _isRheumaticFever, _isHayFever, 
                                          _isRespiratoryProblems, _isJaundice, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                          _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                          _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                          _isBloodDisease, _isHeadInjuries, _isArthritis
                                        );
                                      },
                                    ),
                                    const Text("Arthritis / Rheumatism"),
                                  ],
                                ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Checkbox(
                                    value: _othersDisease,
                                    onChanged: (value) {
                                      setState(() {
                                        _othersDisease = value!;
                                      });
                                      widget.onConditionsChanged(
                                        _isHighBlood, _isLowBlood, _isEpilepsy, _isAIDSorHIV, _isSTD, 
                                        _isUlcers, _isFaintingSeizure, _isRapidWeightLoss, _isRadiationTherapy,
                                        _isJointReplacement, _isHeartSurgery, _isHeartAttack, _isHeartDisease, 
                                        _isHeartMurmur, _isThyroidProblem, _isLiverDisease, _isJaundice, _isRheumaticFever, _isHayFever, 
                                        _isRespiratoryProblems, _isTuberculosis, _isSwollenAnkle, _isKidneyDisease, 
                                        _isDiabetes, _isChestPain, _isStroke, _isCancer, 
                                        _isAnemia, _isAngina, _isAsthma, _isEmphysema, _isBleedingProblem, 
                                        _isBloodDisease, _isHeadInjuries, _isArthritis
                                      );
                                    },
                                  ),
                                  const Text("Others: "),
                                  const SizedBox(width: 5),
                                  // Text field for specifying other allergies
                                  SizedBox(
                                    width: 150, // Adjust width as needed
                                    child: TextFormField(
                                      enabled: _othersDisease,
                                      decoration: const InputDecoration(
                                        hintText: "Specify other disease",
                                        border: UnderlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                  //Submit Button
              ],
            ),
          ),
        ],
      ),
    );              
  }
}
