///This model will be used with the progress indicator.
class ProgressModel {
  //The current page in this step.
  final int currentPage;

  //The total number of pages required to complete this step.
  final int totalPage;

  ProgressModel(this.currentPage, this.totalPage);
}
