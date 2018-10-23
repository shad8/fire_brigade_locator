# README

Application provide to search nearest fire brigade station in passed localization.

## Prepare data:

1. Download example fire brigade information from: https://dane.gov.pl/dataset/1050/resource/11127
2. Load data to application using rake: ```rake import:fire_brigade_data[file_path] ```
3. Generate coordination using rake: ```rake geocode:all  CLASS=FireBrigade```
4. Run application server ```rails s```
