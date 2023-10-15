# Database Transformation Pipeline

This repository hosts a semi-automated pipeline that converts a messy SQLite database into a clean, reliable source for analytics. The pipeline includes:

- Data validation through unit tests
- Error logging
- Automatic changelog updates
- Production database refresh

## Usage Instructions

1. Run `script.sh` and follow the prompts.
2. If necessary, `script.sh` will execute `dev/cleanse_data.py` to validate and clean `dev/cademycode.db`.
3. If errors occur during validation, they will be logged, and the process will terminate.
4. Otherwise, `cleanse_data.py` will update the clean database and changelog.
5. After a successful update, the new record count and update data will be written to `dev/changelog.md`.
6. `script.sh` will check the changelog for updates and request permission to update the production database if needed.

To run the script on the updated database, rename `dev/cademycode_updated.db` to `dev/cademycode.db`.

## Folder Structure

- `script.sh`: A bash script to run the data cleanser and move files to `/prod`.
- `dev/`:
  - `changelog.md`: Automatically updated with each run, logging new records and tracking missing data.
  - `cleanse_data.py`: Runs unit tests and data cleansing on `cademycode.db`.
  - `cademycode_cleansed.db`: Output from `cleanse_data.py`, containing two tables.
  - `cademycode.db`: The raw data database with three tables.
  - `cademycode_updated.db`: An updated version of `cademycode.db` for testing the update process.
- `prod/`:
  - `changelog.md`: Copied from `/dev` when updates are approved.
  - `cademycode_cleansed.db`: Copied from `/dev` when updates are approved.
