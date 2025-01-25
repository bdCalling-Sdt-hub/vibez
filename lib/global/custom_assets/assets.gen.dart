/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:lottie/lottie.dart' as _lottie;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/about.svg
  SvgGenImage get about => const SvgGenImage('assets/icons/about.svg');

  /// File path: assets/icons/arrow_right.svg
  SvgGenImage get arrowRight =>
      const SvgGenImage('assets/icons/arrow_right.svg');

  /// File path: assets/icons/atracFile.svg
  SvgGenImage get atracFile => const SvgGenImage('assets/icons/atracFile.svg');

  /// File path: assets/icons/button.svg
  SvgGenImage get button => const SvgGenImage('assets/icons/button.svg');

  /// File path: assets/icons/calander1.svg
  SvgGenImage get calander1 => const SvgGenImage('assets/icons/calander1.svg');

  /// File path: assets/icons/call.svg
  SvgGenImage get call => const SvgGenImage('assets/icons/call.svg');

  /// File path: assets/icons/changePass.svg
  SvgGenImage get changePass =>
      const SvgGenImage('assets/icons/changePass.svg');

  /// File path: assets/icons/check_ring.svg
  SvgGenImage get checkRing => const SvgGenImage('assets/icons/check_ring.svg');

  /// File path: assets/icons/docFile.svg
  SvgGenImage get docFile => const SvgGenImage('assets/icons/docFile.svg');

  /// File path: assets/icons/drink_light.svg
  SvgGenImage get drinkLight =>
      const SvgGenImage('assets/icons/drink_light.svg');

  /// File path: assets/icons/email.svg
  SvgGenImage get email => const SvgGenImage('assets/icons/email.svg');

  /// File path: assets/icons/filter.svg
  SvgGenImage get filter => const SvgGenImage('assets/icons/filter.svg');

  /// File path: assets/icons/grid.svg
  SvgGenImage get grid => const SvgGenImage('assets/icons/grid.svg');

  /// File path: assets/icons/guestIcon.svg
  SvgGenImage get guestIcon => const SvgGenImage('assets/icons/guestIcon.svg');

  /// File path: assets/icons/location.svg
  SvgGenImage get location => const SvgGenImage('assets/icons/location.svg');

  /// File path: assets/icons/managerIcon.svg
  SvgGenImage get managerIcon =>
      const SvgGenImage('assets/icons/managerIcon.svg');

  /// File path: assets/icons/menu.svg
  SvgGenImage get menu => const SvgGenImage('assets/icons/menu.svg');

  /// File path: assets/icons/notification.svg
  SvgGenImage get notification =>
      const SvgGenImage('assets/icons/notification.svg');

  /// File path: assets/icons/notification2.svg
  SvgGenImage get notification2 =>
      const SvgGenImage('assets/icons/notification2.svg');

  /// File path: assets/icons/password.svg
  SvgGenImage get password => const SvgGenImage('assets/icons/password.svg');

  /// File path: assets/icons/payment.svg
  SvgGenImage get payment => const SvgGenImage('assets/icons/payment.svg');

  /// File path: assets/icons/person.svg
  SvgGenImage get person => const SvgGenImage('assets/icons/person.svg');

  /// File path: assets/icons/person2.svg
  SvgGenImage get person2 => const SvgGenImage('assets/icons/person2.svg');

  /// File path: assets/icons/restaurant icon.svg
  SvgGenImage get restaurantIcon =>
      const SvgGenImage('assets/icons/restaurant icon.svg');

  /// File path: assets/icons/search_light.svg
  SvgGenImage get searchLight =>
      const SvgGenImage('assets/icons/search_light.svg');

  /// File path: assets/icons/setting.svg
  SvgGenImage get setting => const SvgGenImage('assets/icons/setting.svg');

  /// File path: assets/icons/sign_out_circle.svg
  SvgGenImage get signOutCircle =>
      const SvgGenImage('assets/icons/sign_out_circle.svg');

  /// File path: assets/icons/url.svg
  SvgGenImage get url => const SvgGenImage('assets/icons/url.svg');

  /// File path: assets/icons/userIcon.svg
  SvgGenImage get userIcon => const SvgGenImage('assets/icons/userIcon.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        about,
        arrowRight,
        atracFile,
        button,
        calander1,
        call,
        changePass,
        checkRing,
        docFile,
        drinkLight,
        email,
        filter,
        grid,
        guestIcon,
        location,
        managerIcon,
        menu,
        notification,
        notification2,
        password,
        payment,
        person,
        person2,
        restaurantIcon,
        searchLight,
        setting,
        signOutCircle,
        url,
        userIcon
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/applogo.png
  AssetGenImage get applogo => const AssetGenImage('assets/images/applogo.png');

  /// File path: assets/images/onboardingImage.png
  AssetGenImage get onboardingImage =>
      const AssetGenImage('assets/images/onboardingImage.png');

  /// List of all assets
  List<AssetGenImage> get values => [applogo, onboardingImage];
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/buttonLoading.json
  LottieGenImage get buttonLoading =>
      const LottieGenImage('assets/lottie/buttonLoading.json');

  /// File path: assets/lottie/success.json
  LottieGenImage get success =>
      const LottieGenImage('assets/lottie/success.json');

  /// List of all assets
  List<LottieGenImage> get values => [buttonLoading, success];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

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
    bool gaplessPlayback = true,
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
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
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
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
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
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class LottieGenImage {
  const LottieGenImage(
    this._assetName, {
    this.flavors = const {},
  });

  final String _assetName;
  final Set<String> flavors;

  _lottie.LottieBuilder lottie({
    Animation<double>? controller,
    bool? animate,
    _lottie.FrameRate? frameRate,
    bool? repeat,
    bool? reverse,
    _lottie.LottieDelegates? delegates,
    _lottie.LottieOptions? options,
    void Function(_lottie.LottieComposition)? onLoaded,
    _lottie.LottieImageProviderFactory? imageProviderFactory,
    Key? key,
    AssetBundle? bundle,
    Widget Function(
      BuildContext,
      Widget,
      _lottie.LottieComposition?,
    )? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    String? package,
    bool? addRepaintBoundary,
    FilterQuality? filterQuality,
    void Function(String)? onWarning,
  }) {
    return _lottie.Lottie.asset(
      _assetName,
      controller: controller,
      animate: animate,
      frameRate: frameRate,
      repeat: repeat,
      reverse: reverse,
      delegates: delegates,
      options: options,
      onLoaded: onLoaded,
      imageProviderFactory: imageProviderFactory,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: package,
      addRepaintBoundary: addRepaintBoundary,
      filterQuality: filterQuality,
      onWarning: onWarning,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
