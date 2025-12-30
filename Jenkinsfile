@Library('jenkins-shared-library') _

def configMap = [
    project: "roboshop",
    component: "cart"
]

// if branch is not equal to main, then run CI pipeline
if ( ! env.BRANCH_NAME.equalsIgnoreCase('main') ){
    nodejsEKSpipeline(configMap)
}
else {
    echo "Please follow the CR process"
}