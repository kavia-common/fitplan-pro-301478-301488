# Workout Database Schema Documentation

## Overview
PostgreSQL database for FitPlan Pro workout application with comprehensive exercise library and workout tracking capabilities.

## Connection Information
- **Database**: myapp
- **User**: appuser
- **Port**: 5000
- **Connection String**: Available in `db_connection.txt`

## Tables

### users
Stores user account information and fitness preferences.
- `id` (UUID, PK)
- `username` (VARCHAR, UNIQUE)
- `email` (VARCHAR, UNIQUE)
- `password_hash` (VARCHAR)
- `created_at` (TIMESTAMP)
- `fitness_goal` (VARCHAR)
- `experience_level` (VARCHAR)

**Indices**: `idx_users_email`

### equipment
Stores available workout equipment types.
- `id` (SERIAL, PK)
- `name` (TEXT, UNIQUE)

**Seed Data**: 8 equipment types (None, Dumbbell, Barbell, Machine, Resistance Band, Kettlebell, Cable, Pull-up Bar)

### exercises
Comprehensive exercise library with muscle group targeting and calorie data.
- `id` (SERIAL, PK)
- `name` (TEXT, UNIQUE)
- `primary_muscle` (TEXT)
- `secondary_muscle` (TEXT)
- `equipment_id` (INTEGER, FK → equipment.id)
- `calories_per_min` (NUMERIC, default 5.00)

**Indices**: `idx_exercises_name`, `idx_exercises_primary_muscle`

**Seed Data**: 22 exercises covering all major muscle groups

### workouts
Stores workout plans created by users.
- `id` (UUID, PK)
- `user_id` (UUID, FK → users.id, CASCADE DELETE)
- `goal` (TEXT)
- `created_at` (TIMESTAMP)

**Indices**: `idx_workouts_user_id`

### workout_exercises
Junction table linking exercises to workouts with set/rep configuration.
- `id` (SERIAL, PK)
- `workout_id` (UUID, FK → workouts.id, CASCADE DELETE)
- `exercise_id` (INTEGER, FK → exercises.id, CASCADE DELETE)
- `exercise_order` (INTEGER)
- `sets` (INTEGER, default 3)
- `reps` (INTEGER)
- `duration_seconds` (INTEGER)
- `rest_seconds` (INTEGER, default 60)
- `notes` (TEXT)

### workout_logs
Tracks completed workout sessions.
- `id` (UUID, PK)
- `workout_id` (UUID, FK → workouts.id, CASCADE DELETE)
- `performed_at` (TIMESTAMP, default now())
- `duration_minutes` (INTEGER, default 0)

**Indices**: `idx_workout_logs_workout_id`

### exercise_sets
Logs individual set performance within workout sessions.
- `id` (SERIAL, PK)
- `workout_log_id` (UUID, FK → workout_logs.id, CASCADE DELETE)
- `exercise_id` (INTEGER, FK → exercises.id, CASCADE DELETE)
- `set_number` (INTEGER)
- `reps` (INTEGER)
- `weight` (NUMERIC)
- `duration_seconds` (INTEGER)
- `completed_at` (TIMESTAMP)
- `notes` (TEXT)

### goals
Tracks user fitness goals and progress.
- `id` (SERIAL, PK)
- `user_id` (UUID, FK → users.id, CASCADE DELETE)
- `goal_type` (VARCHAR)
- `target_value` (NUMERIC)
- `current_value` (NUMERIC)
- `deadline` (DATE)
- `created_at` (TIMESTAMP)
- `achieved_at` (TIMESTAMP)

## Seed Data Summary

### Equipment (8 types)
1. None - Bodyweight exercises
2. Dumbbell - Free weight exercises
3. Barbell - Compound lifts
4. Machine - Guided resistance exercises
5. Resistance Band - Portable resistance training
6. Kettlebell - Dynamic strength exercises
7. Cable - Variable angle resistance
8. Pull-up Bar - Upper body pulling exercises

### Exercises (22 exercises)

#### Chest
- Push-up (None, 5 cal/min)
- Bench Press (Barbell, 9 cal/min)
- Cable Chest Fly (Cable, 6.5 cal/min)

#### Back
- Dumbbell Row (Dumbbell, 5 cal/min)
- Lat Pulldown (Machine, 5 cal/min)
- Pull-ups (Pull-up Bar, 8 cal/min)
- Deadlift (Barbell, 9 cal/min)

#### Legs
- Squat (Barbell, 5 cal/min)
- Lunges (None, 7 cal/min)
- Leg Press (Machine, 8 cal/min)
- Leg Curls (Machine, 6 cal/min)
- Calf Raises (None, 4.5 cal/min)

#### Shoulders
- Overhead Press (Barbell, 7.5 cal/min)
- Lateral Raises (Dumbbell, 5 cal/min)
- Face Pulls (Cable, 5.5 cal/min)

#### Arms
- Bicep Curls (Dumbbell, 5 cal/min)
- Tricep Dips (None, 6.5 cal/min)

#### Core
- Plank (None, 4 cal/min)
- Russian Twists (None, 5.5 cal/min)
- Mountain Climbers (None, 8.5 cal/min)

#### Full Body
- Kettlebell Swings (Kettlebell, 9.5 cal/min)
- Burpees (None, 10 cal/min)

## Usage Notes

- All SQL statements were executed via psql CLI following single-statement execution rule
- Foreign key constraints ensure referential integrity with CASCADE deletes where appropriate
- Indices optimize common query patterns (user lookups, workout retrieval, exercise filtering)
- Calorie burn rates are estimates per minute of exercise
- UUID primary keys used for users, workouts, and logs for distributed system compatibility
- SERIAL primary keys used for exercises and equipment for simpler reference management

## Database Operations

To connect to the database:
```bash
psql postgresql://appuser:dbuser123@localhost:5000/myapp
```

To view all tables:
```sql
\dt
```

To view seed data:
```sql
SELECT * FROM equipment;
SELECT id, name, primary_muscle, equipment_id FROM exercises;
```
