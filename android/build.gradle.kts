allprojects {
    repositories {
        google()
        mavenCentral()
        maven { url = uri("https://maven.myket.ir/") }
    }
}

val newBuildDir: Directory = layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = layout.buildDirectory.dir("../../../build/${project.name}").get()
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
