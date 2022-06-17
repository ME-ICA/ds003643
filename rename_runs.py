"""Rename the runs in the dataset to start with 01."""
from glob import glob
import os.path as op
import os

IN_DIR = "/home/data/nbc/external-datasets/ds003643"
subjects = sorted(glob(op.join(IN_DIR, "sub-*")))
subjects = [op.basename(subject) for subject in subjects]

for subject in subjects:
    subject_dir = op.join(IN_DIR, subject)
    func_dir = op.join(subject_dir, "func")
    func_files = sorted(glob(op.join(func_dir, "*echo-1*.nii.gz")))
    for i_run, func_file in enumerate(func_files):
        run_number = [p for p in func_file.split("_") if p.startswith("run-")]
        if not run_number:
            print(func_file)

        run_number = run_number[0]
        new_run_number = "run-" + str(i_run + 1).zfill(2)
        all_func_files = sorted(glob(op.join(func_dir, "*" + run_number + "*")))
        for file_to_rename in all_func_files:
            new_file = file_to_rename.replace(run_number, new_run_number)
            filename_to_rename = op.basename(file_to_rename)
            new_filename = op.basename(new_file)
            print(filename_to_rename + " --> " + new_filename, flush=True)
            os.rename(file_to_rename, new_file)
