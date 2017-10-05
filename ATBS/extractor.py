#! python
# extractor.py - finds phone numbers and email addresses on the clipboard

import re
import pyperclip as pp


phoneRegex = re.compile(r'''(
(\d{3}|\(\d{3}\))?             # area code
(\s|-|\.)?                     # separator
(\d{3})                        # first 3 digits
(\s|-|\.)?                     # separator
(\d{4})                        # last 4 digits
(\s*(ext|x|ext.)\s*(\s{2,5}))? # extension
)''', re.VERBOSE|re.S)

# TODO: Create email regex.

emailRegex = re.compile(r'''(
([A-Z0-9]+)
(@)
(\w+)
(\.\w+))''', re.X|re.I)

# TODO: Find matches in clipboard text.

my_text = str(pp.paste())
print(my_text)
matches = []

for groups in phoneRegex.findall(my_text):
    phoneNum = '-'.join([groups[1],groups[3],groups[5]])
    if groups[8]!= '':
        phoneNum += ' x' + groups[8]
    matches.append(phoneNum)
    
for groups in emailRegex.findall(my_text):
    print(groups)
    matches.append(''.join([groups[1],groups[2],groups[3],groups[4]]))

# TODO: Copy results to the clipboard
if len(matches) > 0:
    pp.copy('\n'.join(matches))
    print('Copied to clipboard:')
    print('\n'.join(matches))
else:
    print('No phone numbers or email addresses found')
            

