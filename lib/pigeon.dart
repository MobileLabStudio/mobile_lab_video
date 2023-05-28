// Autogenerated from Pigeon (v10.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

enum VideoPlayerError {
  unknown,
  serverDied,
  io,
  malformed,
  unsupported,
  timedOut,
  system,
}

enum PMediaPlayerState {
  ready,
  buffering,
  ended,
  idle,
}

class VideoDetails {
  VideoDetails({
    required this.width,
    required this.height,
    required this.surfaceId,
  });

  int width;

  int height;

  int surfaceId;

  Object encode() {
    return <Object?>[
      width,
      height,
      surfaceId,
    ];
  }

  static VideoDetails decode(Object result) {
    result as List<Object?>;
    return VideoDetails(
      width: result[0]! as int,
      height: result[1]! as int,
      surfaceId: result[2]! as int,
    );
  }
}

class PMediaPlayerInfo {
  PMediaPlayerInfo({
    required this.textureId,
  });

  int textureId;

  Object encode() {
    return <Object?>[
      textureId,
    ];
  }

  static PMediaPlayerInfo decode(Object result) {
    result as List<Object?>;
    return PMediaPlayerInfo(
      textureId: result[0]! as int,
    );
  }
}

class PVideoMeta {
  PVideoMeta({
    required this.width,
    required this.height,
  });

  int width;

  int height;

  Object encode() {
    return <Object?>[
      width,
      height,
    ];
  }

  static PVideoMeta decode(Object result) {
    result as List<Object?>;
    return PVideoMeta(
      width: result[0]! as int,
      height: result[1]! as int,
    );
  }
}

class PMediaPlayerStateEvent {
  PMediaPlayerStateEvent({
    required this.textureId,
    required this.state,
  });

  int textureId;

  PMediaPlayerState state;

  Object encode() {
    return <Object?>[
      textureId,
      state.index,
    ];
  }

  static PMediaPlayerStateEvent decode(Object result) {
    result as List<Object?>;
    return PMediaPlayerStateEvent(
      textureId: result[0]! as int,
      state: PMediaPlayerState.values[result[1]! as int],
    );
  }
}

class PMediaPlayerNaviteError {
  PMediaPlayerNaviteError({
    required this.textureId,
    required this.details,
  });

  int textureId;

  Map<String?, Object?> details;

  Object encode() {
    return <Object?>[
      textureId,
      details,
    ];
  }

  static PMediaPlayerNaviteError decode(Object result) {
    result as List<Object?>;
    return PMediaPlayerNaviteError(
      textureId: result[0]! as int,
      details: (result[1] as Map<Object?, Object?>?)!.cast<String?, Object?>(),
    );
  }
}

class _VideoPlayerDelegateApiCodec extends StandardMessageCodec {
  const _VideoPlayerDelegateApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is VideoDetails) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128: 
        return VideoDetails.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class VideoPlayerDelegateApi {
  /// Constructor for [VideoPlayerDelegateApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  VideoPlayerDelegateApi({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;
  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _VideoPlayerDelegateApiCodec();

  Future<String> create(String arg_uri) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.VideoPlayerDelegateApi.create', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_uri]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as String?)!;
    }
  }

  Future<VideoDetails> prepare(String arg_playerId) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.VideoPlayerDelegateApi.prepare', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_playerId]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as VideoDetails?)!;
    }
  }

  Future<void> play(String arg_playerId) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.VideoPlayerDelegateApi.play', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_playerId]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> pause(String arg_playerId) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.VideoPlayerDelegateApi.pause', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_playerId]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> release(String arg_playerId) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.VideoPlayerDelegateApi.release', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_playerId]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> seekTo(int arg_milliseconds, String arg_playerId) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.VideoPlayerDelegateApi.seekTo', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_milliseconds, arg_playerId]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> reset(String arg_playerId) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.VideoPlayerDelegateApi.reset', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_playerId]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<bool> isPlaying(String arg_playerId) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.VideoPlayerDelegateApi.isPlaying', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_playerId]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as bool?)!;
    }
  }

  Future<void> releaseAll() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.VideoPlayerDelegateApi.releaseAll', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }
}

abstract class FlutterVideoPlayerApi {
  static const MessageCodec<Object?> codec = StandardMessageCodec();

  /// Called when player enters error state.
  /// The [error] param is index of the [VideoPlayerError] enum.
  /// The [nativePlayerInfo] is info about player which enters error state
  void onError(int error, int surfaceId);

  /// Called when player buffer updates
  void onBuffering(int percent, int surfaceId);

  /// Called when media completes
  void onCompleted(int surfaceId);

  /// Called when player was prepared
  void onPrepared(int surfaceId);

  static void setup(FlutterVideoPlayerApi? api, {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.FlutterVideoPlayerApi.onError', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.FlutterVideoPlayerApi.onError was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_error = (args[0] as int?);
          assert(arg_error != null,
              'Argument for dev.flutter.pigeon.FlutterVideoPlayerApi.onError was null, expected non-null int.');
          final int? arg_surfaceId = (args[1] as int?);
          assert(arg_surfaceId != null,
              'Argument for dev.flutter.pigeon.FlutterVideoPlayerApi.onError was null, expected non-null int.');
          api.onError(arg_error!, arg_surfaceId!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.FlutterVideoPlayerApi.onBuffering', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.FlutterVideoPlayerApi.onBuffering was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_percent = (args[0] as int?);
          assert(arg_percent != null,
              'Argument for dev.flutter.pigeon.FlutterVideoPlayerApi.onBuffering was null, expected non-null int.');
          final int? arg_surfaceId = (args[1] as int?);
          assert(arg_surfaceId != null,
              'Argument for dev.flutter.pigeon.FlutterVideoPlayerApi.onBuffering was null, expected non-null int.');
          api.onBuffering(arg_percent!, arg_surfaceId!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.FlutterVideoPlayerApi.onCompleted', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.FlutterVideoPlayerApi.onCompleted was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_surfaceId = (args[0] as int?);
          assert(arg_surfaceId != null,
              'Argument for dev.flutter.pigeon.FlutterVideoPlayerApi.onCompleted was null, expected non-null int.');
          api.onCompleted(arg_surfaceId!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.FlutterVideoPlayerApi.onPrepared', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.FlutterVideoPlayerApi.onPrepared was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_surfaceId = (args[0] as int?);
          assert(arg_surfaceId != null,
              'Argument for dev.flutter.pigeon.FlutterVideoPlayerApi.onPrepared was null, expected non-null int.');
          api.onPrepared(arg_surfaceId!);
          return;
        });
      }
    }
  }
}

class _PMediaPlayerFactoryCodec extends StandardMessageCodec {
  const _PMediaPlayerFactoryCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is PMediaPlayerInfo) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128: 
        return PMediaPlayerInfo.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class PMediaPlayerFactory {
  /// Constructor for [PMediaPlayerFactory].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  PMediaPlayerFactory({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;
  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _PMediaPlayerFactoryCodec();

  Future<PMediaPlayerInfo> createHttpVideoPlayer(String arg_httpUrl, String? arg_tag) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PMediaPlayerFactory.createHttpVideoPlayer', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_httpUrl, arg_tag]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as PMediaPlayerInfo?)!;
    }
  }

  Future<PMediaPlayerInfo> createHLSVideoStream(String arg_hlsUrl, String? arg_tag) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PMediaPlayerFactory.createHLSVideoStream', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_hlsUrl, arg_tag]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as PMediaPlayerInfo?)!;
    }
  }
}

class _PMediaPlayerCodec extends StandardMessageCodec {
  const _PMediaPlayerCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is PVideoMeta) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128: 
        return PVideoMeta.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class PMediaPlayer {
  /// Constructor for [PMediaPlayer].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  PMediaPlayer({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;
  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _PMediaPlayerCodec();

  Future<void> prepare() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PMediaPlayer.prepare', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> play() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PMediaPlayer.play', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> pause() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PMediaPlayer.pause', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> playPause() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PMediaPlayer.playPause', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> seekTo(int arg_millisecond) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PMediaPlayer.seekTo', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_millisecond]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> reuse() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PMediaPlayer.reuse', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> release() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PMediaPlayer.release', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<PVideoMeta> getVideoMeta() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PMediaPlayer.getVideoMeta', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as PVideoMeta?)!;
    }
  }
}

class _PMediaPlayerProxyCodec extends StandardMessageCodec {
  const _PMediaPlayerProxyCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is PMediaPlayerInfo) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is PVideoMeta) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128: 
        return PMediaPlayerInfo.decode(readValue(buffer)!);
      case 129: 
        return PVideoMeta.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class PMediaPlayerProxy {
  /// Constructor for [PMediaPlayerProxy].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  PMediaPlayerProxy({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;
  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _PMediaPlayerProxyCodec();

  Future<void> prepare(PMediaPlayerInfo arg_mediaPlayerInfo) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PMediaPlayerProxy.prepare', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_mediaPlayerInfo]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> play(PMediaPlayerInfo arg_mediaPlayerInfo) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PMediaPlayerProxy.play', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_mediaPlayerInfo]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> pause(PMediaPlayerInfo arg_mediaPlayerInfo) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PMediaPlayerProxy.pause', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_mediaPlayerInfo]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> playPause(PMediaPlayerInfo arg_mediaPlayerInfo) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PMediaPlayerProxy.playPause', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_mediaPlayerInfo]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> seekTo(PMediaPlayerInfo arg_mediaPlayerInfo, int arg_millisecond) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PMediaPlayerProxy.seekTo', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_mediaPlayerInfo, arg_millisecond]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> reuse(PMediaPlayerInfo arg_mediaPlayerInfo) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PMediaPlayerProxy.reuse', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_mediaPlayerInfo]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> release(PMediaPlayerInfo arg_mediaPlayerInfo) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PMediaPlayerProxy.release', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_mediaPlayerInfo]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<PVideoMeta> getVideoMeta(PMediaPlayerInfo arg_mediaPlayerInfo) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.PMediaPlayerProxy.getVideoMeta', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_mediaPlayerInfo]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as PVideoMeta?)!;
    }
  }
}

class _PMediaPlayerListenerCodec extends StandardMessageCodec {
  const _PMediaPlayerListenerCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is PMediaPlayerNaviteError) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is PMediaPlayerStateEvent) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128: 
        return PMediaPlayerNaviteError.decode(readValue(buffer)!);
      case 129: 
        return PMediaPlayerStateEvent.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class PMediaPlayerListener {
  static const MessageCodec<Object?> codec = _PMediaPlayerListenerCodec();

  void onStateChanged(PMediaPlayerStateEvent stateEvent);

  void onError(PMediaPlayerNaviteError naviteError);

  static void setup(PMediaPlayerListener? api, {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.PMediaPlayerListener.onStateChanged', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.PMediaPlayerListener.onStateChanged was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final PMediaPlayerStateEvent? arg_stateEvent = (args[0] as PMediaPlayerStateEvent?);
          assert(arg_stateEvent != null,
              'Argument for dev.flutter.pigeon.PMediaPlayerListener.onStateChanged was null, expected non-null PMediaPlayerStateEvent.');
          api.onStateChanged(arg_stateEvent!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.PMediaPlayerListener.onError', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.PMediaPlayerListener.onError was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final PMediaPlayerNaviteError? arg_naviteError = (args[0] as PMediaPlayerNaviteError?);
          assert(arg_naviteError != null,
              'Argument for dev.flutter.pigeon.PMediaPlayerListener.onError was null, expected non-null PMediaPlayerNaviteError.');
          api.onError(arg_naviteError!);
          return;
        });
      }
    }
  }
}
