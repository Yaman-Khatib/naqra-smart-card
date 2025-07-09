import 'package:naqra_web/mock/mock_profile_data.dart';
import 'package:naqra_web/models/profile.dart';

abstract class ProfileAdapter {
  Future<Profile> fetchProfile(String profileID);
}

//* Why we used implement not extends
// We use 'extends' when you want to reuse and build upon an existing class //Take something and add other.
// Use implements when you want to implement a specific interface or contract without inheriting code //No reuse of code just.


// class ApiProfileAdapter implements ProfileAdapter
// {
//   Future<Profile> fetchProfile(String profileID)
//   {
//     return Profile(name: 'name', bio: 'bio', keywords: ['keywords'], position: 'position', contacts: []);
//   }
// }

class MockProfileAdapter implements ProfileAdapter
{
  @override
  Future<Profile> fetchProfile(String profileId)
  {    
    return Future.delayed(Duration(milliseconds: 1700),() => profile );
  }
}