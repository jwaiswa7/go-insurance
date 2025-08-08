# Go-Insurance Application

A Rails-based insurance application for managing claims and policies.

## Prerequisites

- Rails version: 8.0.2
- Ruby version: 3.2.2
- Docker and Docker Compose
- Node.js (for E2E tests)

## Quick Start

### Using Docker (Recommended)

1. Build the application:
```bash
docker compose build
```

2. Start the application:
```bash
docker compose up
```

This will:
- Start the Rails server
- Run database migrations
- Import seed data from Excel files in `lib/databases/`
- Make the application available at http://localhost:3000

### Manual Setup (Alternative)

1. Install dependencies:
```bash
bundle install
```

2. Setup database and import data:
```bash
./bin/rails db:create db:migrate
./bin/rake import_databases:all
```

3. Start the server:
```bash
./bin/rails server
```

## Testing

### Backend Tests
```bash
# Run from project root
bundle exec rspec
```

### End-to-End Tests
```bash
# Run from project root
npm install              # First time only
npm run test:e2e
```

## Development Tools

### Code Quality
```bash
./bin/rubocop           # Style checking
./bin/brakeman         # Security analysis
```

### Documentation
```bash
bundle exec erd        # Generate Entity-Relationship Diagram
```

## Project Overview

### Key Directories
```
app/
├── controllers/        # Request handling
├── models/            # Business logic
├── views/             # UI templates
├── javascript/        # Frontend code
└── services/          # Business services

config/                # App configuration
db/                    # Database files
lib/databases/         # Seed data (Excel)
spec/                  # RSpec tests
e2e/                  # Playwright tests
```

### Technology Stack

- **Backend**: Rails 8.0.2
- **Database**: SQLite
- **Frontend**: 
  - Turbo & Stimulus
  - TailwindCSS
  - Hotwire
- **Testing**: 
  - RSpec (Backend)
  - Playwright (E2E)
- **Infrastructure**: Docker

## Troubleshooting

### Docker Issues

- **Port conflicts**: Ensure port 3000 is available
- **Reset containers**: 
  ```bash
  docker compose down
  docker volume rm go_insurance_rails_db
  ```

### Local Setup Issues

- **Ruby version**: Run `ruby -v` to verify version 3.2.2
- **Dependencies**: Run `bundle install` to update gems
- **Database issues**: 
  ```bash
  ./bin/rails db:reset
  ./bin/rake import_databases:all
  ```
- **Server won't start**: Remove `tmp/pids/server.pid` if it exists

## Contributing

1. Fork the repository
2. Create your feature branch
3. Run tests before submitting PR
4. Submit a pull request

## License

This project is proprietary software. All rights reserved.