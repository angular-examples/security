import 'package:angular/angular.dart';
import 'package:angular/security.dart';

/// NOTE: this implementation is incomplete. Current content is provided
/// as a placeholder.
@Component(
  selector: 'bypass-security',
  templateUrl: 'bypass_security_component.html',
)
class BypassSecurityComponent {
  DomSanitizationService sanitizer;
  String dangerousUrl;
  SafeUrl trustedUrl;
  String dangerousVideoUrl;
  SafeResourceUrl videoUrl;

  BypassSecurityComponent(this.sanitizer) {
    // javascript: URLs are dangerous if attacker controlled.
    // Angular sanitizes them in data binding, but we can
    // explicitly tell Angular to trust this value:
    dangerousUrl = 'javascript:alert("Hi there")';
    trustedUrl =
        sanitizer.bypassSecurityTrustUrl('javascript:alert("Hi there")');
    updateVideoUrl('PUBnlbjZFAI');
  }
  void updateVideoUrl(String id) {
    // Appending an ID to a YouTube URL is safe.
    // Always make sure to construct SafeValue objects as
    // close as possible to the input data, so
    // that it's easier to check if the value is safe.
    dangerousVideoUrl = 'https://www.youtube.com/embed/$id';
    videoUrl = sanitizer.bypassSecurityTrustResourceUrl(dangerousVideoUrl);
  }
}
