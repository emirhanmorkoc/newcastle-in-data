# Cleaning Log

- Removed deleted records (record_status = D): 0 rows
- Removed duplicate transaction IDs: 0 rows
- Removed rows with missing postcode: 63 rows
- Removed property_type = O (other): 2248 rows
- Removed prices below GBP 10,000: 1 rows
- Removed price outliers (3x IQR per property type): 851 rows
- START: 39916 rows, END: 36753 rows