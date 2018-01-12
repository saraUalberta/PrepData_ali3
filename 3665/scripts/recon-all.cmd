

#---------------------------------
# New invocation of recon-all Thu Jan 11 00:48:43 UTC 2018 

 mri_convert /home/ubuntu/sMRI/3665.nii /usr/local/freesurfer/subjects/3665/mri/orig/001.mgz 

#--------------------------------------------
#@# MotionCor Thu Jan 11 00:48:47 UTC 2018

 cp /usr/local/freesurfer/subjects/3665/mri/orig/001.mgz /usr/local/freesurfer/subjects/3665/mri/rawavg.mgz 


 mri_convert /usr/local/freesurfer/subjects/3665/mri/rawavg.mgz /usr/local/freesurfer/subjects/3665/mri/orig.mgz --conform 


 mri_add_xform_to_header -c /usr/local/freesurfer/subjects/3665/mri/transforms/talairach.xfm /usr/local/freesurfer/subjects/3665/mri/orig.mgz /usr/local/freesurfer/subjects/3665/mri/orig.mgz 

#--------------------------------------------
#@# Talairach Thu Jan 11 00:49:02 UTC 2018

 mri_nu_correct.mni --no-rescale --i orig.mgz --o orig_nu.mgz --n 1 --proto-iters 1000 --distance 50 


 talairach_avi --i orig_nu.mgz --xfm transforms/talairach.auto.xfm 

talairach_avi log file is transforms/talairach_avi.log...

 cp transforms/talairach.auto.xfm transforms/talairach.xfm 

#--------------------------------------------
#@# Talairach Failure Detection Thu Jan 11 00:52:49 UTC 2018

 talairach_afd -T 0.005 -xfm transforms/talairach.xfm 


 awk -f /usr/local/freesurfer/bin/extract_talairach_avi_QA.awk /usr/local/freesurfer/subjects/3665/mri/transforms/talairach_avi.log 


 tal_QC_AZS /usr/local/freesurfer/subjects/3665/mri/transforms/talairach_avi.log 

#--------------------------------------------
#@# Nu Intensity Correction Thu Jan 11 00:52:50 UTC 2018

 mri_nu_correct.mni --i orig.mgz --o nu.mgz --uchar transforms/talairach.xfm --n 2 

