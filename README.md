# impmed: A Stata Module for Causal Mediation Analysis Using Pure Regression Imputation

`impmed` is a Stata module designed to perform causal mediation analysis using pure regression imputation, suitable for scenarios with single or multiple mediators.

## Syntax

```stata
impmed depvar mvars, dvar(varname) d(real) dstar(real) yreg(string) [options]
```

### Required Arguments

- `depvar`: Specifies the outcome variable.
- `mvars`: Specifies the mediator(s), which can be a single variable or multivariate.
- `dvar(varname)`: Specifies the treatment (exposure) variable.
- `d(real)`: Reference level of treatment.
- `dstar(real)`: Alternative level of treatment, defining the treatment contrast of interest.
- `yreg(string)`: Specifies the form of the regression models to be estimated for the outcome. Options include `regress` and `logit`.

### Options

- `cvars(varlist)`: Specifies the list of baseline covariates to be included in the analysis. Categorical variables need to be coded as a series of dummy variables before being entered as covariates.
- `nointeraction`: Specifies whether treatment-mediator interactions are not to be included in the outcome model (default assumes interactions are present).
- `cxd`: Includes all two-way interactions between the treatment and baseline covariates in all the outcome models.
- `cxm`: Includes all two-way interactions between the mediators and baseline covariates in the outcome model.
- `detail`: Prints the fitted models for the outcome used to construct effect estimates.
- `bootstrap_options`: All `bootstrap` options are available.

## Description

`impmed` estimates three models for causal mediation analysis:
1. A model for the outcome conditional on the exposure and baseline covariates.
2. A model for the outcome conditional on the exposure, baseline covariates, and mediator(s).
3. A model for the predicted values obtained from the previous model, conditional on the exposure and baseline covariates.

This approach provides estimates of total, natural direct, and natural indirect effects when a single mediator is specified. It provides estimates of multivariate natural direct and indirect effects for multiple mediators.

`impmed` allows sampling weights via the `pweights` option, but it does not internally rescale them for use with the bootstrap. If using weights from a complex sample design that require rescaling to produce valid boostrap estimates, the user must be sure to appropriately specify the `strata`, `cluster`, and `size` options from the `bootstrap` command so that Nc-1 clusters are sampled within from each stratum, where Nc denotes the number of clusters per stratum. Failure to properly adjust the bootstrap sampling to account for a complex sample design that requires weighting could lead to invalid inferential statistics.

## Examples

```stata
// Load data
use nlsy79.dta

// Single mediator with default settings
impmed std_cesd_age40 ever_unemp_age3539, dvar(att22) cvars(female black hispan paredu parprof parinc_prank famsize afqt3) d(1) dstar(0) yreg(regress) 

// Single mediator with all two-way interactions and 1000 bootstrap replications
impmed std_cesd_age40 ever_unemp_age3539, dvar(att22) cvars(female black hispan paredu parprof parinc_prank famsize afqt3) d(1) dstar(0) yreg(regress) cxd cxm reps(1000)

// Multiple mediators with 1000 bootstrap replications
impmed std_cesd_age40 ever_unemp_age3539 log_faminc_adj_age3539, dvar(att22) cvars(female black hispan paredu parprof parinc_prank famsize afqt3) d(1) dstar(0) yreg(regress) reps(1000)
```

## Saved Results

`impmed` saves the following results in `e()`:

- **Matrices**:
  - `e(b)`: Matrix containing direct, indirect, and total effect estimates.

## Author

Geoffrey T. Wodtke  
Department of Sociology  
University of Chicago

Email: [wodtke@uchicago.edu](mailto:wodtke@uchicago.edu)

## References

- Wodtke, GT and X Zhou. Causal Mediation Analysis. In preparation.

## Also See

- Help: [regress R](#), [logit R](#), [bootstrap R](#)
