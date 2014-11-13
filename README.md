ICtoolbox
====================================

toolbox for model order identification

ICtoolbox  Copyright (C) 2014 Nicholas Roseveare
    This program comes with ABSOLUTELY NO WARRANTY; for details see the LICENSE file
    This is free software, and you are welcome to redistribute it
    under certain conditions; see LICENSE file for conditions

====================================

For out-of-the-box functionality on

 - Simulated two-channel data, use: 'mcInfoCriterionTest.m' and create reusable scenarios with ID numbers in 'loadParamsScenTest.m'
 
 - Collected data (real or complex-proper), use: 'infoCriterion.m' - this is the main information criteria function which the above simulated data generator calls
 
For further information on how to use these functions, use the matlab help command, or see the code preamble.

====================================

The key to the various Information Criteria is the following:

AIC, BIC: Akaike IC, Bayesian  IC*

AIC_fsFit, BIC_fsFit:
	AIC and BIC for the two-channel 'full signal' fit

AIC_jointXFit, BIC_jointXFit:
	AIC and BIC for the two-channel 'cross term' fit

AIC_indv, BIC_indv:
	AIC and BIC for the fit of each channel individually (non-joint solution)

AIC_crossOnly, BIC_crossOnly: 
	AIC and BIC for the cross fit only, not consider the PCA reduction of the individual channels

*Bayesian IC is also known as MDL (minimum description length) criterion

====================================

You are welcome to send a comment or question via the gitHub interface.
