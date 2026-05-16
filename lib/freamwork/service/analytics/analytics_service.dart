import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'analytics_event.dart';

@lazySingleton
class AnalyticsService {
  final FirebaseAnalytics _analytics;

  AnalyticsService(this._analytics);

  /// Track a screen view
  Future<void> trackScreenView(String screenName) async {
    try {
      await _analytics.logScreenView(screenName: screenName);
      debugPrint('Analytics: ScreenView -> $screenName');
    } catch (e) {
      debugPrint('Analytics Error (ScreenView): $e');
    }
  }

  /// Track a custom event
  Future<void> trackCustomEvent(String name, {Map<String, Object>? parameters}) async {
    try {
      await _analytics.logEvent(name: name, parameters: parameters);
      debugPrint('Analytics: Event -> $name, Params: $parameters');
    } catch (e) {
      debugPrint('Analytics Error (Event $name): $e');
    }
  }

  /// Specialized method for portfolio visit
  Future<void> trackPortfolioVisited() async {
    await trackCustomEvent(
      AnalyticsEvent.portfolioVisited,
      parameters: {AnalyticsEvent.paramPlatform: kIsWeb ? 'web' : 'mobile'},
    );
  }

  /// Specialized method for project open
  Future<void> trackProjectOpen(String projectName) async {
    await trackCustomEvent(
      AnalyticsEvent.projectOpened,
      parameters: {AnalyticsEvent.paramProjectName: projectName},
    );
  }

  /// Specialized method for resume download
  Future<void> trackResumeDownload() async {
    await trackCustomEvent(AnalyticsEvent.resumeDownloaded);
  }

  /// Specialized method for contact message sent
  Future<void> trackContactMessageSent() async {
    await trackCustomEvent(AnalyticsEvent.contactMessageSent);
  }

  /// Specialized method for social clicks
  Future<void> trackSocialClick(String platform) async {
    final event = platform.toLowerCase() == 'github'
        ? AnalyticsEvent.githubClicked
        : AnalyticsEvent.linkedinClicked;
    await trackCustomEvent(event);
  }

  /// Specialized method for skill section view
  Future<void> trackSkillSectionViewed(String sectionName) async {
    await trackCustomEvent(
      AnalyticsEvent.skillSectionViewed,
      parameters: {AnalyticsEvent.paramSectionName: sectionName},
    );
  }
}
