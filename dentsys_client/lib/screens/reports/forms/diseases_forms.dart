import 'package:flutter/material.dart';

class DiseasesForms extends StatefulWidget {

  const DiseasesForms({super.key, required GlobalKey<FormState> formKey});

  @override
  DiseasesFormsState createState() => DiseasesFormsState();
}

class DiseasesFormsState extends State<DiseasesForms> {
  final _diseasesFormKey = GlobalKey<FormState>();

  bool _isHighBlood = false;
  bool _isLowBlood = false;
  bool _isEpilepsy = false;
  bool _isAIDSorHIV = false;
  bool _isSTD = false;
  bool _isUlcers = false;
  bool _isFaintingSeizure = false;
  bool _isRapidWeigthLoss = false;
  bool _isRadiationTherapy = false;

  bool _isJointReplacement = false;
  bool _isHeartSurgery = false;
  bool _isHeartAttack = false;
  bool _isThyroidProblem= false;
  bool _isHeartDisease = false;
  bool _isHeartMurmur = false;
  bool _isLiverDisease = false;
  bool _isRheumaticFever = false;
  bool _isHayFever = false;

  bool _isRespiratoryProblems = false;
  bool _isJaundice = false;
  bool _isTuberculosis = false;
  bool _isSwollenAnkles= false;
  bool _isKidneyDisease = false;
  bool _isDiabetes = false;
  bool _isChestPain = false;
  bool _isStroke = false;
  bool _isCancer = false;

  bool _isAnemia = false;
  bool _isAngina = false;
  bool _isAsthma = false;
  bool _isEmphysema = false;
  bool _isBleedingProblem = false;
  bool _isBloodDisease = false;
  bool _isHeadInjuries = false;
  bool _isArthritis = false;
  bool _othersDisease = false;

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
                                      value: _isRapidWeigthLoss,
                                      onChanged: (value) {
                                        setState(() {
                                          _isRapidWeigthLoss = value!;
                                        });
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
                                    value: _isSwollenAnkles,
                                    onChanged: (value) {
                                      setState(() {
                                        _isSwollenAnkles = value!;
                                      });
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
