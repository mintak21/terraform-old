# terraform files
## directory structure

```bash
├── cicd/         # CI setting files
├── environments/ # IaC files
├── module/       # terraform modules
└── scripts/
   ├── aws/       # scripts to use aws-cli
   ├── ci/        # scripts to use codebuild ci
   └── setup/     # scripts to setup
```

## CI
continuous integration on AWS CodeBuild project.
check below.

- format
- validate
- lint
- plan & notify Pull Requests

![image](https://user-images.githubusercontent.com/57534475/85926096-ebb1d100-b8d7-11ea-8ad0-e88ca6f74e71.png)


## setup
```bash
make setup_macos # for MacOS
```

## fmt
```bash
make fmt
```
