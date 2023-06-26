After preprocessing, the data is now ready for first-level (participant-level) analysis. The goal of the analysis at this level is to extract the parameters (beta-maps and contrast images) for each individual participant to take to the second- (group-) level analysis. Unexplained variance from the individual subjects is discarded at this level. 

### Step 1: Model Formulation (General Linear Model)
`y = xb + e`
> fMRI signal (matrix of BOLD signals) = design matrix * betas + residuals
We want to find the best fitting model. After constructing the design matrix, we can then find the beta values that minimize the sum of squared residuals (unexplained variance between observed and predicted values).

### Step 2: Obtain Contrasts
To apply the contrast principle ([task with P] - [matched task without P] = P), you can enter the contrasts in SPM directly. Essentially, this creates a sum of the beta-maps with multiplication of the regressors by (usually) 1 or -1.
