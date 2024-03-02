export const environment = {
  production: true,
  baseApiUrl: "http://fhir-server:8080/fhir/",
  planDefenition: "PlanDefinition"
};

export const url = {
  PlanDefinition: environment.baseApiUrl + "PlanDefinition/",
  Task: environment.baseApiUrl + "Task" + "?status=completed&_count=10000",
  CarePlanStatus: environment.baseApiUrl + "CarePlan?status=completed&instantiates-canonical=PlanDefinition/",
  Patient: environment.baseApiUrl + "Patient",
};
