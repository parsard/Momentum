
plugins {

    id("com.google.gms.google-services")  apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

// Ensures the ":app" module is evaluated first
subprojects {
    project.evaluationDependsOn(":app")
}

// Register the "clean" task to delete the build directory
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
