﻿# Steps

- **1. Install docker related components on server machine.**
- **2. Add [YOUR_USERNAME] to docker group to use docker commands without 'sudo' prefix.**
- **3. Checkout this repository on server machine.**
- **4. Copy `template.env` as `.env` file and fill environment variables values.**
- **5. Copy `s3-config.template.json` as `s3-config.json` file and specify production values inside.**
- **6. Run `docker compose up -d` in the repository root.**