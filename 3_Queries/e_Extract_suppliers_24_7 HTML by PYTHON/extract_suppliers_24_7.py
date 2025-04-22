## !!!!!!!!!!!!
#Before running the script, make sure your XML file is in the C:/ of your PC, as the mentionned in the code.
#The script will parse the XML file and extract the suppliers who work on 24/7.
#It will generate an HTML file with the extracted suppliers and open it in the default browser.
#The HTML file will contain a table with the suppliers' name, phone number, intervention area, and activity.
#Thanks for your attention. I hope you will enjoy in it !
# Marie-Caroline





# Import the required modules

import xml.etree.ElementTree as ET # Import the ElementTree module for parsing XML
import os  # Import the os module for file operations
import webbrowser # Import the webbrowser module to open the generated HTML file in the default browser

# Use the path to the XML file
xml_file = "C:/ESTATEPLATEFORME.xml"

# Print the path to the XML file
print(f"Chemin du fichier XML : {xml_file}")

# Check if the file exists
if not os.path.isfile(xml_file):
    print(f"File not found: {xml_file}")
    exit(1)

# parse the XML file - get the root element - https://docs.python.org/3/library/xml.etree.elementtree.html 
tree = ET.parse(xml_file)
root = tree.getroot()


# get the suppliers on HoursOnCallDuty
available_suppliers = []
for supplier in root.findall(".//SUPPLIER"):
    SUPPLIERHOURSINTERVENTION = supplier.find("SUPPLIERHOURSINTERVENTION")
    if SUPPLIERHOURSINTERVENTION is not None:
        print(f"Found SUPPLIERHOURSINTERVENTION: {SUPPLIERHOURSINTERVENTION.text.strip()}")
        if SUPPLIERHOURSINTERVENTION.text.strip() == "HourlyOnCallDuty":
            SUPPLIERNAME = supplier.find("SUPPLIERNAME").text if supplier.find("SUPPLIERNAME") is not None else "Unknown"
            SUPPLIERTEL = supplier.find("SUPPLIERTEL").text if supplier.find("SUPPLIERTEL") is not None else "Unknown"
            SUPPLIERZONEINTERVENTION = supplier.find("SUPPLIERZONEINTERVENTION").text if supplier.find("SUPPLIERZONEINTERVENTION") is not None else "Unknown"
            SUPPLIERACTIVITY = supplier.find("SUPPLIERACTIVITY").text if supplier.find("SUPPLIERACTIVITY") is not None else "Unknown"
            available_suppliers.append({
                "name": SUPPLIERNAME,
                "SUPPLIERTEL": SUPPLIERTEL,
                "SUPPLIERZONEINTERVENTION": SUPPLIERZONEINTERVENTION,
                "SUPPLIERACTIVITY": SUPPLIERACTIVITY
            })
            print(f"Added supplier: {SUPPLIERNAME}")

if not available_suppliers:
    print("No suppliers found with SUPPLIERHOURSINTERVENTION 'HourlyOnCallDuty'")


# generate the HTML content

html_content = f"""<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Suppliers Disponibles 24/24 </title>
    <style>
        table {{
            width: 100%;
            border-collapse: collapse;
        }}
        table, th, td {{
            border: 1px solid DodgerBlue;
        }}
        th {{
            color: DodgerBlue;
        }}
        td {{
            color: black;
        }}
        th, td {{
            padding: 8px;
            text-align: center;
        }}
    </style>
</head>
<body>
    <h1 style="color: DodgerBlue; text-align: center;">All the Suppliers working on 24/7</h1>
    <table>
        <tr>
            <th>Name</th>
            <th>Phone Number</th>
            <th>Intervention Area</th>
            <th>ACTIVITY</th>
        </tr>
"""

for supplier in available_suppliers:
    html_content += f"""        <tr>
            <td>{supplier['name']}</td>
            <td>{supplier['SUPPLIERTEL']}</td>
            <td>{supplier['SUPPLIERZONEINTERVENTION']}</td>
            <td>{supplier['SUPPLIERACTIVITY']}</td>
        </tr>
"""

html_content += """    </table>
</body>
</html>
"""

# generate the HTML file
html_file_path = "suppliers_24_24.html"
with open(html_file_path, "w", encoding="utf-8") as file:
        file.write(html_content)
print(f"HTML has been generated: {html_file_path}")


# open the generated HTML file in the default browser
webbrowser.open(f"file://{os.path.abspath(html_file_path)}")


