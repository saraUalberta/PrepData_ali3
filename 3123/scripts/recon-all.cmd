

#---------------------------------
# New invocation of recon-all Sun Dec 31 02:03:28 UTC 2017 

 mri_convert /home/ubuntu/sMRI/3123.nii /usr/local/freesurfer/subjects/3123/mri/orig/001.mgz 

#--------------------------------------------
#@# MotionCor Sun Dec 31 02:03:36 UTC 2017

 cp /usr/local/freesurfer/subjects/3123/mri/orig/001.mgz /usr/local/freesurfer/subjects/3123/mri/rawavg.mgz 


 mri_convert /usr/local/freesurfer/subjects/3123/mri/rawavg.mgz /usr/local/freesurfer/subjects/3123/mri/orig.mgz --conform 


 mri_add_xform_to_header -c /usr/local/freesurfer/subjects/3123/mri/transforms/talairach.xfm /usr/local/freesurfer/subjects/3123/mri/orig.mgz /usr/local/freesurfer/subjects/3123/mri/orig.mgz 

#--------------------------------------------
#@# Talairach Sun Dec 31 02:04:01 UTC 2017

 mri_nu_correct.mni --no-rescale --i orig.mgz --o orig_nu.mgz --n 1 --proto-iters 1000 --distance 50 


 talairach_avi --i orig_nu.mgz --xfm transforms/talairach.auto.xfm 

talairach_avi log file is transforms/talairach_avi.log...

 cp transforms/talairach.auto.xfm transforms/talairach.xfm 

#--------------------------------------------
#@# Talairach Failure Detection Sun Dec 31 02:08:43 UTC 2017

 talairach_afd -T 0.005 -xfm transforms/talairach.xfm 


 awk -f /usr/local/freesurfer/bin/extract_talairach_avi_QA.awk /usr/local/freesurfer/subjects/3123/mri/transforms/talairach_avi.log 


 tal_QC_AZS /usr/local/freesurfer/subjects/3123/mri/transforms/talairach_avi.log 

#--------------------------------------------
#@# Nu Intensity Correction Sun Dec 31 02:08:44 UTC 2017

 mri_nu_correct.mni --i orig.mgz --o nu.mgz --uchar transforms/talairach.xfm --n 2 


 mri_add_xform_to_header -c /usr/local/freesurfer/subjects/3123/mri/transforms/talairach.xfm nu.mgz nu.mgz 

#--------------------------------------------
#@# Intensity Normalization Sun Dec 31 02:15:01 UTC 2017

 mri_normalize -g 1 -mprage nu.mgz T1.mgz 

#--------------------------------------------
#@# Skull Stripping Sun Dec 31 02:21:23 UTC 2017

 mri_em_register -rusage /usr/local/freesurfer/subjects/3123/touch/rusage.mri_em_register.skull.dat -skull nu.mgz /usr/local/freesurfer/average/RB_all_withskull_2016-05-10.vc700.gca transforms/talairach_with_skull.lta 


 mri_watershed -rusage /usr/local/freesurfer/subjects/3123/touch/rusage.mri_watershed.dat -T1 -brain_atlas /usr/local/freesurfer/average/RB_all_withskull_2016-05-10.vc700.gca transforms/talairach_with_skull.lta T1.mgz brainmask.auto.mgz 


 cp brainmask.auto.mgz brainmask.mgz 

#-------------------------------------
#@# EM Registration Sun Dec 31 03:20:11 UTC 2017

 mri_em_register -rusage /usr/local/freesurfer/subjects/3123/touch/rusage.mri_em_register.dat -uns 3 -mask brainmask.mgz nu.mgz /usr/local/freesurfer/average/RB_all_2016-05-10.vc700.gca transforms/talairach.lta 

#--------------------------------------
#@# CA Normalize Sun Dec 31 04:04:18 UTC 2017

 mri_ca_normalize -c ctrl_pts.mgz -mask brainmask.mgz nu.mgz /usr/local/freesurfer/average/RB_all_2016-05-10.vc700.gca transforms/talairach.lta norm.mgz 

#--------------------------------------
#@# CA Reg Sun Dec 31 04:08:54 UTC 2017

 mri_ca_register -rusage /usr/local/freesurfer/subjects/3123/touch/rusage.mri_ca_register.dat -nobigventricles -T transforms/talairach.lta -align-after -mask brainmask.mgz norm.mgz /usr/local/freesurfer/average/RB_all_2016-05-10.vc700.gca transforms/talairach.m3z 

#--------------------------------------
#@# SubCort Seg Sun Dec 31 06:37:55 UTC 2017

 mri_ca_label -relabel_unlikely 9 .3 -prior 0.5 -align norm.mgz transforms/talairach.m3z /usr/local/freesurfer/average/RB_all_2016-05-10.vc700.gca aseg.auto_noCCseg.mgz 

