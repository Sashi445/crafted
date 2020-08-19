import 'package:crafted/models/project_class.dart';

class ProjectFromJson{

  Map<String, dynamic> baseClass = {
    "Project Name" : "",
    "projectDescription" : "",
    "purpose" : "",
    "mobileNumber" : "",
    "user" : {
      "uid" : "",
      "displayName" : "",
      "photoUrl" : "",
      "email" : ""
    },
    "domains" : [
      {
        "text" : "Shopping App",
        "value" : false
      },
      {
        "text" : "Social Media App",
        "value" : false
      },
      {
        "text" : "Art and Media",
        "value" : false
      },
      {
        "text" : "Travel App",
        "value" : false
      },
      {
        "text" : "Business and Finance App",
        "value" : false
      },
      {
        "text" : "Health and Fitness App",
        "value" : false
      },
      {
        "text" : "Productivity",
        "value" : false
      },
      {
        "text" : "Weather App",
        "value" : false
      },
      {
        "text" : "Video players and editors",
        "value" : false
      },
      {
        "text" : "Photography",
        "value" : false
      },
      {
        "text" : "None of the above",
        "value" : false
      }
    ],
    "platforms" : [
      {
        "text" : "Android",
        "value" : false
      },
      {
        "text" : "IOS",
        "value" : false
      },
      {
        "text" : "Web",
        "value" : false
      }
    ],
    "timeForCompletion" : [
      {
        "text" : "1 day",
        "value" : false
      },
      {
        "text" : "15 days",
        "value" : false
      },
      {
        "text" : "1 month",
        "value" : false
      },
      {
        "text" : "3 months",
        "value" : false
      }
    ]
  };


  Project loadProject(){
    Project project = Project.fromJson(baseClass);
    return project;
  }
}

