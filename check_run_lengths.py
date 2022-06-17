import nibabel as nib
import pandas as pd
from glob import glob
import os.path as op

IN_DIR = '/home/data/nbc/external-datasets/ds003643'
all_files = sorted(glob(op.join(IN_DIR, "sub-*/func/sub-*echo-1*nii.gz")))
subjects = sorted(glob(op.join(IN_DIR, "sub-*")))
subjects = [op.basename(sub) for sub in subjects]
df = pd.DataFrame(index=subjects)

for f in all_files:
    filename = op.basename(f)
    subject = [p for p in filename.split("_") if p.startswith("sub-")][0]
    print(subject, flush=True)
    run = [p for p in filename.split("_") if p.startswith("run-")][0]
    img = nib.load(f)
    n_vols = img.shape[3]
    df.loc[subject, run] = n_vols

df.to_csv("lpp_run_lengths.tsv", sep="\t", index=True, index_label="subject")
