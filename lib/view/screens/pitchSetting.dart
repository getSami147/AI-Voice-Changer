import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:voice_changer/utils/Colors.dart';
import 'package:voice_changer/utils/Images.dart';
import 'package:voice_changer/utils/widget.dart';
import 'package:voice_changer/view/screens/voiceScreen.dart';
import 'package:voice_changer/viewModel/userViewModel2.dart';

import '../../utils/Constant.dart';
import '../../utils/string.dart';

class PitchSetting extends StatefulWidget {
  const PitchSetting({super.key});

  @override
  State<PitchSetting> createState() => _PitchSettingState();
}

class _PitchSettingState extends State<PitchSetting> {
  double pitchChangeMin = -3.0;
  double pitchChangeMax = 3.0;

  double overAllPitchChangeMin = -12.0;
  double overAllPitchChangeMax = 12.0;

  double indexRateMin = 0.0;
  double indexRateMax = 100.0;

  double filterRadiusMin = -7;
  double filterRadiusMax = 7;

  double rmsMaxRateMin = 0.0;
  double rmsMaxRateMax = 100.0;

  double protectRateMin = 0.0;
  double protectRateMax = 100.0;

  double mianVocalsMin = -20.0;
  double mianVocalsMax = 20.0;

  double backupVocalsMin = -20.0;
  double backupVocalsMax = 20.0;

  double musicMin = -20.0;
  double musicMax = 20.0;

  double romSizeMin = 0.0;
  double romSizeMax = 100.0;

  double wetnessLevelMin = 0.0;
  double wetnessLevelMax = 100.0;

  double drynessLevelMin = 0.0;
  double drynessLevelMax = 100.0;

  double dampingLevelMin = 0.0;
  double dampingLevelMax = 100.0;

  @override
  Widget build(BuildContext context) {
    var sliderProvider = Provider.of<UserViewModel2>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                customizeVoice,
                height: 216,
                width: 316,
                fit: BoxFit.cover,
              ).paddingTop(spacing_standard_new),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text("Pitch Change",
                        googleFonts: GoogleFonts.lato(
                          fontWeight: FontWeight.w600,
                          fontSize: textSizeMedium,
                        )),
                    Row(
                      children: [
                        VolumeValue(
                          value: pitchChangeMin.toInt(),
                        ),
                        Expanded(
                          child: Slider(
                            value: sliderProvider.pitchChange,
                            onChanged: (newValue) {
                              sliderProvider.updatePitchChange(newValue);
                            },
                            inactiveColor: textGreyColor,
                            activeColor: colorPrimary,
                            min: pitchChangeMin,
                            max: pitchChangeMax,
                            divisions: (pitchChangeMax - pitchChangeMin).toInt(),
                            label:
                                sliderProvider.pitchChange.toStringAsFixed(0),
                          ),
                        ),
                        VolumeValue(
                          value: pitchChangeMax.toInt(),
                        ),
                      ],
                    ),
                  ],
                ).paddingSymmetric(
                    horizontal: spacing_standard_new, vertical: spacing_twinty),
              )
                  .paddingTop(spacing_large)
                  .paddingSymmetric(horizontal: spacing_twinty),
             
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text("Over All Pitch",
                        googleFonts: GoogleFonts.lato(
                          fontWeight: FontWeight.w600,
                          fontSize: textSizeMedium,
                        )),
                    Row(
                      children: [
                        VolumeValue(
                          value: overAllPitchChangeMin.toInt(),
                        ),
                        Expanded(
                          child: Slider(
                            value: sliderProvider.overAllPitchChange,
                            onChanged: (newValue) {
                              sliderProvider.updateOverAllPitch(newValue);
                            },
                            inactiveColor: textGreyColor,
                            activeColor: colorPrimary,
                            min: overAllPitchChangeMin,
                            max: overAllPitchChangeMax,
                            divisions: (overAllPitchChangeMax - overAllPitchChangeMin).toInt(),
                            label: sliderProvider.overAllPitchChange
                                .toStringAsFixed(0),
                          ),
                        ),
                        VolumeValue(
                          value: overAllPitchChangeMax.toInt(),
                        ),
                      ],
                    ),
                  ],
                ).paddingSymmetric(
                    horizontal: spacing_standard_new, vertical: spacing_twinty),
              )
                  .paddingTop(spacing_standard_new)
                  .paddingSymmetric(horizontal: spacing_twinty),
             
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text("Index Rate (%)",
                        googleFonts: GoogleFonts.lato(
                          fontWeight: FontWeight.w600,
                          fontSize: textSizeMedium,
                        )),
                    Row(
                      children: [
                        VolumeValue(
                          value: indexRateMin.toInt(),
                        ),
                        Expanded(
                          child: Slider(
                            value: sliderProvider.indexRate,
                            onChanged: (newValue) {
                              sliderProvider.updateIndexRate(newValue);
                            },
                            inactiveColor: textGreyColor,
                            activeColor: colorPrimary,
                            min: indexRateMin,
                            max: indexRateMax,
                            divisions: (indexRateMax - indexRateMin).toInt(),
                            label:
                                sliderProvider.indexRate.toStringAsFixed(0),
                          ),
                        ),
                        VolumeValue(
                          value: indexRateMax.toInt(),
                        ),
                      ],
                    ),
                  ],
                ).paddingSymmetric(
                    horizontal: spacing_standard_new, vertical: spacing_twinty),
              )
                  .paddingTop(spacing_standard_new)
                  .paddingSymmetric(horizontal: spacing_twinty),
              
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text("Filter Radius",
                        googleFonts: GoogleFonts.lato(
                          fontWeight: FontWeight.w600,
                          fontSize: textSizeMedium,
                        )),
                    Row(
                      children: [
                        VolumeValue(
                          value: filterRadiusMin.toInt(),
                        ),
                        Expanded(
                          child: Slider(
                            value: sliderProvider.filterRadius,
                            onChanged: (newValue) {
                              sliderProvider.updateFilterRadius(newValue);
                            },
                            inactiveColor: textGreyColor,
                            activeColor: colorPrimary,
                            min: filterRadiusMin,
                            max: filterRadiusMax,
                            divisions: (filterRadiusMax - filterRadiusMin).toInt(),
                            label: sliderProvider.filterRadius.toStringAsFixed(0),
                          ),
                        ),
                        VolumeValue(
                          value: filterRadiusMax.toInt(),
                        ),
                      ],
                    ),
                  ],
                ).paddingSymmetric(
                    horizontal: spacing_standard_new, vertical: spacing_twinty),
              )
                  .paddingTop(spacing_standard_new)
                  .paddingSymmetric(horizontal: spacing_twinty),
              
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text("RMS Max Rate",
                        googleFonts: GoogleFonts.lato(
                          fontWeight: FontWeight.w600,
                          fontSize: textSizeMedium,
                        )),
                    Row(
                      children: [
                        VolumeValue(
                          value: rmsMaxRateMin.toInt(),
                        ),
                        Expanded(
                          child: Slider(
                            value: sliderProvider.rmsMaxRate,
                            onChanged: (newValue) {
                              sliderProvider.updateRMsMaxRate(newValue);
                            },
                            inactiveColor: textGreyColor,
                            activeColor: colorPrimary,
                            min: rmsMaxRateMin,
                            max: rmsMaxRateMax,
                            divisions: (rmsMaxRateMax - rmsMaxRateMin).toInt(),
                            label:
                                sliderProvider.rmsMaxRate.toStringAsFixed(0),
                          ),
                        ),
                        VolumeValue(
                          value: rmsMaxRateMax.toInt(),
                        ),
                      ],
                    ),
                  ],
                ).paddingSymmetric(
                    horizontal: spacing_standard_new, vertical: spacing_twinty),
              )
                  .paddingTop(spacing_large)
                  .paddingSymmetric(horizontal: spacing_twinty),
              
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text("Protect Rate",
                        googleFonts: GoogleFonts.lato(
                          fontWeight: FontWeight.w600,
                          fontSize: textSizeMedium,
                        )),
                    Row(
                      children: [
                        VolumeValue(
                          value: protectRateMin.toInt(),
                        ),
                        Expanded(
                          child: Slider(
                            value: sliderProvider.protectRate,
                            onChanged: (newValue) {
                              sliderProvider.updateProtectRate(newValue);
                            },
                            inactiveColor: textGreyColor,
                            activeColor: colorPrimary,
                            min: protectRateMin,
                            max: protectRateMax,
                            divisions: (protectRateMax - protectRateMin).toInt(),
                            label: sliderProvider.protectRate
                                .toStringAsFixed(0),
                          ),
                        ),
                        VolumeValue(
                          value: protectRateMax.toInt(),
                        ),
                      ],
                    ),
                  ],
                ).paddingSymmetric(
                    horizontal: spacing_standard_new, vertical: spacing_twinty),
              )
                  .paddingTop(spacing_standard_new)
                  .paddingSymmetric(horizontal: spacing_twinty),
              
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text("Mian Vocals",
                        googleFonts: GoogleFonts.lato(
                          fontWeight: FontWeight.w600,
                          fontSize: textSizeMedium,
                        )),
                    Row(
                      children: [
                        VolumeValue(
                          value: mianVocalsMin.toInt(),
                        ),
                        Expanded(
                          child: Slider(
                            value: sliderProvider.mianVocals,
                            onChanged: (newValue) {
                              sliderProvider.updateMianVocals(newValue);
                            },
                            inactiveColor: textGreyColor,
                            activeColor: colorPrimary,
                            min: mianVocalsMin,
                            max: mianVocalsMax,
                            divisions: (mianVocalsMax - mianVocalsMin).toInt(),
                            label:
                                sliderProvider.mianVocals.toStringAsFixed(0),
                          ),
                        ),
                        VolumeValue(
                          value: mianVocalsMax.toInt(),
                        ),
                      ],
                    ),
                  ],
                ).paddingSymmetric(
                    horizontal: spacing_standard_new, vertical: spacing_twinty),
              )
                  .paddingTop(spacing_standard_new)
                  .paddingSymmetric(horizontal: spacing_twinty),
              
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text("Backup Vocals",
                        googleFonts: GoogleFonts.lato(
                          fontWeight: FontWeight.w600,
                          fontSize: textSizeMedium,
                        )),
                    Row(
                      children: [
                        VolumeValue(
                          value: backupVocalsMin.toInt(),
                        ),
                        Expanded(
                          child: Slider(
                            value: sliderProvider.backupVocals,
                            onChanged: (newValue) {
                              sliderProvider.updateBackupVocals(newValue);
                            },
                            inactiveColor: textGreyColor,
                            activeColor: colorPrimary,
                            min: backupVocalsMin,
                            max: backupVocalsMax,
                            divisions: (backupVocalsMax - backupVocalsMin).toInt(),
                            label: sliderProvider.backupVocals.toStringAsFixed(0),
                          ),
                        ),
                        VolumeValue(
                          value: backupVocalsMax.toInt(),
                        ),
                      ],
                    ),
                  ],
                ).paddingSymmetric(
                    horizontal: spacing_standard_new, vertical: spacing_twinty),
              )
                  .paddingTop(spacing_standard_new)
                  .paddingSymmetric(horizontal: spacing_twinty),
              
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text("Music",
                        googleFonts: GoogleFonts.lato(
                          fontWeight: FontWeight.w600,
                          fontSize: textSizeMedium,
                        )),
                    Row(
                      children: [
                        VolumeValue(
                          value: musicMin.toInt(),
                        ),
                        Expanded(
                          child: Slider(
                            value: sliderProvider.music,
                            onChanged: (newValue) {
                              sliderProvider.updateMusic(newValue);
                            },
                            inactiveColor: textGreyColor,
                            activeColor: colorPrimary,
                            min: musicMin,
                            max: musicMax,
                            divisions: (musicMax - musicMin).toInt(),
                            label:
                                sliderProvider.music.toStringAsFixed(0),
                          ),
                        ),
                        VolumeValue(
                          value: musicMax.toInt(),
                        ),
                      ],
                    ),
                  ],
                ).paddingSymmetric(
                    horizontal: spacing_standard_new, vertical: spacing_twinty),
              )
                  .paddingTop(spacing_large)
                  .paddingSymmetric(horizontal: spacing_twinty),
             
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text("Room Size",
                        googleFonts: GoogleFonts.lato(
                          fontWeight: FontWeight.w600,
                          fontSize: textSizeMedium,
                        )),
                    Row(
                      children: [
                        VolumeValue(
                          value: romSizeMin.toInt(),
                        ),
                        Expanded(
                          child: Slider(
                            value: sliderProvider.romSize,
                            onChanged: (newValue) {
                              sliderProvider.updateRomSize(newValue);
                            },
                            inactiveColor: textGreyColor,
                            activeColor: colorPrimary,
                            min: romSizeMin,
                            max: romSizeMax,
                            divisions: (romSizeMax - romSizeMin).toInt(),
                            label: sliderProvider.romSize
                                .toStringAsFixed(0),
                          ),
                        ),
                        VolumeValue(
                          value: romSizeMax.toInt(),
                        ),
                      ],
                    ),
                  ],
                ).paddingSymmetric(
                    horizontal: spacing_standard_new, vertical: spacing_twinty),
              )
                  .paddingTop(spacing_standard_new)
                  .paddingSymmetric(horizontal: spacing_twinty),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text("Wetness Level",
                        googleFonts: GoogleFonts.lato(
                          fontWeight: FontWeight.w600,
                          fontSize: textSizeMedium,
                        )),
                    Row(
                      children: [
                        VolumeValue(
                          value: wetnessLevelMin.toInt(),
                        ),
                        Expanded(
                          child: Slider(
                            value: sliderProvider.wetnessLevel,
                            onChanged: (newValue) {
                              sliderProvider.updateWetnessLevel(newValue);
                            },
                            inactiveColor: textGreyColor,
                            activeColor: colorPrimary,
                            min: wetnessLevelMin,
                            max: wetnessLevelMax,
                            divisions: (wetnessLevelMax - wetnessLevelMin).toInt(),
                            label:
                                sliderProvider.wetnessLevel.toStringAsFixed(0),
                          ),
                        ),
                        VolumeValue(
                          value: wetnessLevelMax.toInt(),
                        ),
                      ],
                    ),
                  ],
                ).paddingSymmetric(
                    horizontal: spacing_standard_new, vertical: spacing_twinty),
              )
                  .paddingTop(spacing_standard_new)
                  .paddingSymmetric(horizontal: spacing_twinty),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text("Dryness Level",
                        googleFonts: GoogleFonts.lato(
                          fontWeight: FontWeight.w600,
                          fontSize: textSizeMedium,
                        )),
                    Row(
                      children: [
                        VolumeValue(
                          value: drynessLevelMin.toInt(),
                        ),
                        Expanded(
                          child: Slider(
                            value: sliderProvider.drynessLevel,
                            onChanged: (newValue) {
                              sliderProvider.updateDrynessLevel(newValue);
                            },
                            inactiveColor: textGreyColor,
                            activeColor: colorPrimary,
                            min: drynessLevelMin,
                            max: drynessLevelMax,
                            divisions: (drynessLevelMax - drynessLevelMin).toInt(),
                            label: sliderProvider.drynessLevel.toStringAsFixed(0),
                          ),
                        ),
                        VolumeValue(
                          value: drynessLevelMax.toInt(),
                        ),
                      ],
                    ),
                  ],
                ).paddingSymmetric(
                    horizontal: spacing_standard_new, vertical: spacing_twinty),
              )
                  .paddingTop(spacing_standard_new)
                  .paddingSymmetric(horizontal: spacing_twinty),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text("Damping Level",
                        googleFonts: GoogleFonts.lato(
                          fontWeight: FontWeight.w600,
                          fontSize: textSizeMedium,
                        )),
                    Row(
                      children: [
                        VolumeValue(
                          value: dampingLevelMin.toInt(),
                        ),
                        Expanded(
                          child: Slider(
                            value: sliderProvider.dampingLevel,
                            onChanged: (newValue) {
                              sliderProvider.updateDampingLevel(newValue);
                            },
                            inactiveColor: textGreyColor,
                            activeColor: colorPrimary,
                            min: dampingLevelMin,
                            max: dampingLevelMax,
                            divisions: (dampingLevelMax - dampingLevelMin).toInt(),
                            label: sliderProvider.dampingLevel.toStringAsFixed(0),
                          ),
                        ),
                        VolumeValue(
                          value: dampingLevelMax.toInt(),
                        ),
                      ],
                    ),
                  ],
                ).paddingSymmetric(
                    horizontal: spacing_standard_new, vertical: spacing_twinty),
              )
                  .paddingTop(spacing_standard_new)
                  .paddingSymmetric(horizontal: spacing_twinty),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class VolumeValue extends StatelessWidget {
  var value;
  VolumeValue({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
        borderRadius: BorderRadius.circular(3),
      ),
      child: text(value.toString(),
          googleFonts: GoogleFonts.lato(
            fontWeight: FontWeight.w500,
            fontSize: textSizeSMedium,
          )).paddingSymmetric(horizontal: 6),
    );
  }
}
