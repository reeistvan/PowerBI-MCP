import csv
import random
from datetime import date, timedelta

random.seed(42)

regions = ["Budapest", "Nyugat", "Kelet", "Észak", "Dél"]
products = ["Casco", "Lakás", "Utas", "Élet", "Vállalati"]
claim_types = ["Elemi kár", "Lopás", "Baleset"]

rows = []

for i in range(1, 201):
    claim_id = f"CLM{i:03d}"

    start_date = date(2024, 1, 1)
    end_date = date(2025, 12, 31)
    delta_days = (end_date - start_date).days
    claim_date = start_date + timedelta(days=random.randint(0, delta_days))

    region = random.choice(regions)
    product = random.choice(products)
    claim_type = random.choice(claim_types)

    if i <= 40:
        amount = random.randint(500001, 2000000)
    else:
        amount = random.randint(50000, 2000000)

    rows.append([claim_id, claim_date.strftime("%Y-%m-%d"), region, product, claim_type, amount])

output_path = "data/Claims.csv"

with open(output_path, "w", newline="", encoding="utf-8") as csvfile:
    writer = csv.writer(csvfile)
    writer.writerow(["ClaimID", "ClaimDate", "RegionName", "ProductName", "ClaimType", "ClaimAmount"])
    writer.writerows(rows)
