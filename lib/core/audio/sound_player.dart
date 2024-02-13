import 'package:audioplayers/audioplayers.dart';

abstract class SoundPlayer {
  Future<void> play(String path);
}

// Before every item made a new AudioPlayer, now the whole app shares one
// and it stops the last sound before playing the next one.
class AudioplayersSoundPlayer implements SoundPlayer {
  final AudioPlayer _player = AudioPlayer();

  @override
  Future<void> play(String path) async {
    await _player.stop();
    await _player.play(AssetSource(path));
  }
}
