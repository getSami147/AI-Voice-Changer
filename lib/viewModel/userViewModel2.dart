import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class UserViewModel2 with ChangeNotifier {
    bool _generatedloading = false;
  bool get generatedloading => _generatedloading;

  setLoading(bool value) {
    _generatedloading = value;
    notifyListeners();
  }
  bool isExpanded = false;
  var timeValue = 'Last 7 days';
// pith Slider.....
var selectedValue;
var actorId;

  double pitchChange = 0.0;
  double overAllPitchChange = 0.0;
  double indexRate = 50.0;
  double filterRadius = 3;
  double rmsMaxRate = 25;
  double protectRate = 33;
  double mianVocals = 0.0;
  double backupVocals = 0.0;
  double music = 0.0;
  double romSize = 15;
  double wetnessLevel = 20;
  double drynessLevel = 80;
  double dampingLevel = 70;
  
  // Extended Floating Action Button............>>
  void toggleExpansion() {
    isExpanded = !isExpanded;
    notifyListeners();
  }
  // select Actor............>>
  void selectActorMethod(index, id) {
    selectedValue = index;
    actorId = id;
    notifyListeners();
  }

  // Seleting Payment Cards.....
   int? selectedCardIndex;
  void selectedCardMethod(int index) {
    selectedCardIndex = index;
    notifyListeners();
  }
  // dropdown change values....
  void changeDropdownValue(value) {
    timeValue = value!;
    notifyListeners();
  }

  void updatePitchChange(double newValue) {
    pitchChange = newValue;
    notifyListeners();
  }

  void updateOverAllPitch(double newValue) {
    overAllPitchChange = newValue;
    notifyListeners();
  }

  void updateIndexRate(double newValue) {
    indexRate = newValue;
    notifyListeners();
  }

  void updateFilterRadius(double newValue) {
    filterRadius = newValue;
    notifyListeners();
  }

  void updateRMsMaxRate(double newValue) {
    rmsMaxRate = newValue;
    notifyListeners();
  }

  void updateProtectRate(double newValue) {
    protectRate = newValue;
    notifyListeners();
  }

  void updateMianVocals(double newValue) {
    mianVocals = newValue;
    notifyListeners();
  }

  void updateBackupVocals(double newValue) {
    backupVocals = newValue;
    notifyListeners();
  }

  void updateMusic(double newValue) {
    music = newValue;
    notifyListeners();
  }

  void updateRomSize(double newValue) {
    romSize = newValue;
    notifyListeners();
  }

  void updateWetnessLevel(double newValue) {
    wetnessLevel = newValue;
    notifyListeners();
  }

  void updateDrynessLevel(double newValue) {
    drynessLevel = newValue;
    notifyListeners();
  }

  void updateDampingLevel(double newValue) {
    dampingLevel = newValue;
    notifyListeners();
  }

///  Audio Player ......
 

  final AudioPlayer audioPlayer = AudioPlayer();
  Duration duration = Duration();
  Duration position = Duration();
  bool isPlaying = false;
  bool isLoading = false;
  bool isPause = false;

  void changeSeek(double musicValue) {
    audioPlayer.seek(Duration(seconds: musicValue.toInt()));
  }

  Future<void> playAudio(String url) async {
    if (isPause) {
      await audioPlayer.play();
      isPlaying = true;
      isPause = false;
    } else if (isPlaying) {
      await audioPlayer.pause();
      isPlaying = false;
      isPause = true;
    } else {
      isLoading = true;
      await audioPlayer.setUrl(url);
      await audioPlayer.play(); // You need to call play() after setting the URL
      isPlaying = true;
    }

    audioPlayer.durationStream.listen((d) {
      duration = d ?? Duration(); // Handle the case where duration is null
      isLoading = false;
      notifyListeners();
    });

    audioPlayer.positionStream.listen((p) {
      position = p ?? Duration(); // Handle the case where position is null
      notifyListeners();
    });

    audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        isPlaying = false;
        duration = Duration();
        position = Duration();
        notifyListeners();
      }
    });
  }

  void dispose() {
    audioPlayer.dispose();
  }
}





