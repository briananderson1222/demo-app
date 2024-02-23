plugins {
	java
	jacoco
	id("org.springframework.boot") version "3.2.2"
	id("io.spring.dependency-management") version "1.1.4"
	id("org.sonarqube") version "4.4.1.3373"
}

group = "app"
version = "0.0.1-SNAPSHOT"

java {
	sourceCompatibility = JavaVersion.VERSION_21
}

repositories {
	mavenCentral()
}

dependencies {
	implementation("org.springframework.boot:spring-boot-starter-actuator")
	implementation("org.springframework.boot:spring-boot-starter-web")
	testImplementation("org.springframework.boot:spring-boot-starter-test")
}

tasks.withType<Test> {
	useJUnitPlatform()
}

sonar {
  properties {
    property("sonar.projectKey", "briananderson1222_demo-app")
    property("sonar.organization", "briananderson1222")
    property("sonar.host.url", "https://sonarcloud.io")
	property("sonar.coverage.jacoco.xmlReportPaths", "build/reports/jacoco")
  }
}

tasks.jacocoTestReport {
	dependsOn(tasks.test) // tests are required to run before generating the report
	reports {
        xml.required = true
    }
}