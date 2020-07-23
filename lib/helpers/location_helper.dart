const GOOGLE_API_KEY = 'AIzaSyBkIxHiNQOhcseoyUiSGJsLwteeSb3UXXo';

class LocationHelper {
  static String getLocationPreviewImage({double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x250&maptype=roadmap&markers=color:red%7Alabel:C%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }
}
