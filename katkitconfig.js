[
  {
    "EnvName": "default",
    "LocalFleet": "true",
    "WorkFlow": [
      {
        "Name": "PRE_DEPLOY_BUILD",
        "PhaseType": 4,
        "BuildParams": "PHASE=PRE_DEPLOY_BUILD, FOO=BAR1",
        "Order": 0,
        "Parallelism": 1,
        "ContainerImage": "duplocloud/zbuilder:lambda_v11"
      }
    ]
  } 
]
