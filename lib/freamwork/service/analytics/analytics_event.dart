class AnalyticsEvent {
  AnalyticsEvent._();

  // Event Names
  static const String portfolioVisited = 'portfolio_visited';
  static const String projectOpened = 'project_opened';
  static const String resumeDownloaded = 'resume_downloaded';
  static const String githubClicked = 'github_clicked';
  static const String linkedinClicked = 'linkedin_clicked';
  static const String contactMessageSent = 'contact_message_sent';
  static const String skillSectionViewed = 'skill_section_viewed';
  static const String screenView = 'screen_view';

  // Parameter Keys
  static const String paramProjectName = 'project_name';
  static const String paramSectionName = 'section_name';
  static const String paramScreenName = 'screen_name';
  static const String paramPlatform = 'platform';
}
