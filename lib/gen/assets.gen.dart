/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

class $AssetImageGen {
  const $AssetImageGen();

  /// File path: asset/image/angry.svg
  SvgGenImage get angry => const SvgGenImage('asset/image/angry.svg');

  /// File path: asset/image/annoyed.svg
  SvgGenImage get annoyed => const SvgGenImage('asset/image/annoyed.svg');

  /// File path: asset/image/confused.svg
  SvgGenImage get confused => const SvgGenImage('asset/image/confused.svg');

  /// File path: asset/image/cool.svg
  SvgGenImage get cool => const SvgGenImage('asset/image/cool.svg');

  /// File path: asset/image/cry.svg
  SvgGenImage get cry => const SvgGenImage('asset/image/cry.svg');

  /// File path: asset/image/happy.svg
  SvgGenImage get happy => const SvgGenImage('asset/image/happy.svg');

  /// File path: asset/image/heart-eyes.svg
  SvgGenImage get heartEyes => const SvgGenImage('asset/image/heart-eyes.svg');

  /// File path: asset/image/logo.png
  AssetGenImage get logo => const AssetGenImage('asset/image/logo.png');

  /// File path: asset/image/mask.svg
  SvgGenImage get mask => const SvgGenImage('asset/image/mask.svg');

  /// File path: asset/image/naughty.svg
  SvgGenImage get naughty => const SvgGenImage('asset/image/naughty.svg');

  /// File path: asset/image/party.svg
  SvgGenImage get party => const SvgGenImage('asset/image/party.svg');

  /// File path: asset/image/sad.svg
  SvgGenImage get sad => const SvgGenImage('asset/image/sad.svg');

  /// File path: asset/image/shocked.svg
  SvgGenImage get shocked => const SvgGenImage('asset/image/shocked.svg');

  /// File path: asset/image/sleep.svg
  SvgGenImage get sleep => const SvgGenImage('asset/image/sleep.svg');

  /// File path: asset/image/smile.svg
  SvgGenImage get smile => const SvgGenImage('asset/image/smile.svg');

  /// File path: asset/image/splash.png
  AssetGenImage get splash => const AssetGenImage('asset/image/splash.png');

  /// File path: asset/image/tears.svg
  SvgGenImage get tears => const SvgGenImage('asset/image/tears.svg');

  /// File path: asset/image/think.svg
  SvgGenImage get think => const SvgGenImage('asset/image/think.svg');

  /// File path: asset/image/very_happy.svg
  SvgGenImage get veryHappy => const SvgGenImage('asset/image/very_happy.svg');

  /// File path: asset/image/worry.svg
  SvgGenImage get worry => const SvgGenImage('asset/image/worry.svg');

  /// List of all assets
  List<dynamic> get values => [
        angry,
        annoyed,
        confused,
        cool,
        cry,
        happy,
        heartEyes,
        logo,
        mask,
        naughty,
        party,
        sad,
        shocked,
        sleep,
        smile,
        splash,
        tears,
        think,
        veryHappy,
        worry
      ];
}

class Assets {
  Assets._();

  static const $AssetImageGen image = $AssetImageGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size = null});

  final String _assetName;

  final Size? size;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size = null,
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size = null,
  }) : _isVecFormat = true;

  final String _assetName;

  final Size? size;
  final bool _isVecFormat;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture(
      _isVecFormat
          ? AssetBytesLoader(_assetName, assetBundle: bundle, packageName: package)
          : SvgAssetLoader(_assetName, assetBundle: bundle, packageName: package),
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter ?? (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
