import os
import shutil

archive_dir = 'archive_pages'
if not os.path.exists(archive_dir):
    os.makedirs(archive_dir)

files_to_move = [
    'InCIT2026.html', 'camera.html', 'committee.html', 
    'cultural-visit.html', 'keynote.html', 'misc.html', 
    'online-program.html', 'onsite-program.html', 'other-info.html', 
    'sessions.html', 'test.html'
]

for file in files_to_move:
    if os.path.exists(file):
        shutil.move(file, os.path.join(archive_dir, file))
        print(f"Moved {file} to {archive_dir}/")
    else:
        print(f"File {file} not found.")
