class JobUiModel {
  final String title;
  final String location;
  final String salary;
  final String jobType;
  final String company;
  final String applyLink;

  JobUiModel(
    {
    required this.title,
    required this.location,
    required this.salary,
    required this.jobType,
    required this.company,
    required this.applyLink,
  });

  factory JobUiModel.fromJson(Map<String, dynamic> json) {
    return JobUiModel(
      title: json['title'] ?? '',
      location: json['location']['display_name'] ?? '',
      salary: (json['salary_min'] ?? 0).toString(),
      jobType: json['contract_time'] ?? '',
      company: json['company']['display_name'] ?? '',
      applyLink: json['redirect_url'] ?? '',
    );
  }
}
