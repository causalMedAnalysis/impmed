{smcl}
{* *! version 0.1, 1 July 2024}{...}
{cmd:help for impmed}{right:Geoffrey T. Wodtke}
{hline}

{title:Title}

{p2colset 5 18 18 2}{...}
{p2col : {cmd:impmed} {hline 2}}causal mediation analysis using pure regression imputation {p_end}
{p2colreset}{...}


{title:Syntax}

{p 8 18 2}
{cmd:impmed} {depvar} {help indepvars:mvars} {ifin} [{it:{help weight:pweight}}] {cmd:,} 
{opt dvar(varname)} 
{opt d(real)} 
{opt dstar(real)} 
{opt yreg(string)}
{opt cvars(varlist)} 
{opt nointer:action} 
{opt cxd} 
{opt cxm} 
{opt detail}
[{it:{help bootstrap##options:bootstrap_options}}]

{phang}{opt depvar} - this specifies the outcome variable.

{phang}{opt mvars} - this specifies the mediator(s), which can be multivariate.

{phang}{opt dvar(varname)} - this specifies the treatment (exposure) variable.

{phang}{opt d(real)} - this specifies the reference level of treatment.

{phang}{opt dstar(real)} - this specifies the alternative level of treatment. Together, (d - dstar) defines
the treatment contrast of interest.

{phang}{opt yreg}{cmd:(}{it:string}{cmd:)} - this specifies the form of the models to be estimated for the outcome. 
Options are {opt regress} and {opt logit}.

{title:Options}

{phang}{opt cvars(varlist)} - this option specifies the list of baseline covariates to be included in the analysis. Categorical 
variables need to be coded as a series of dummy variables before being entered as covariates.

{phang}{opt nointer:action} - this option specifies whether treatment-mediator interactions are not to be
included in the appropriate outcome model (the default assumes interactions are present).

{phang}{opt cxd} - this option specifies that all two-way interactions between the treatment and baseline covariates are
included in all the outcome models.

{phang}{opt cxm} - this option specifies that all two-way interactions between the mediators and baseline covariates are
included in the relevant outcome model.

{phang}{opt detail} - this option prints the fitted models for the outcome used to construct effect estimates.

{phang}{it:{help bootstrap##options:bootstrap_options}} - all {help bootstrap} options are available. {p_end}

{title:Description}

{pstd}{cmd:impmed} performs causal mediation analysis using pure regression imputation. Three models are 
estimated to construct the effect estimates: a model for the outcome conditional on the exposure and 
baseline covariates (if specified), a model for the outcome conditional on the exposure, baseline covariates,
and the mediator(s), and finally, a model for the predicted values obtained from the previous model, 
conditional on the exposure and baseline covariates.

{pstd}{cmd:impmed} provides estimates of the total, natural direct, and natural indirect effects when a single
mediator is specified. When multiple mediators are specified, it provides estimates for the multivariate natural 
direct and indirect effects operating through the entire set of mediators considered together. {p_end}

{pstd}If using {help pweights} from a complex sample design that require rescaling to produce valid boostrap estimates, be sure to appropriately 
specify the strata(), cluster(), and size() options from the {help bootstrap} command so that Nc-1 clusters are sampled from each stratum 
with replacement, where Nc denotes the number of clusters per stratum. Failing to properly adjust the bootstrap procedure to account
for a complex sample design and its associated sampling weights could lead to invalid inferential statistics. {p_end}

{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. use nlsy79.dta} {p_end}

 
{pstd} percentile bootstrap CIs with default settings, single mediator: {p_end}
 
{phang2}{cmd:. impmed std_cesd_age40 ever_unemp_age3539, dvar(att22) cvars(female black hispan paredu parprof parinc_prank famsize afqt3) d(1) dstar(0) yreg(regress)} {p_end}

 
{pstd} percentile bootstrap CIs with default settings, single mediator, all two-way interactions: {p_end}
 
{phang2}{cmd:. impmed std_cesd_age40 ever_unemp_age3539, dvar(att22) cvars(female black hispan paredu parprof parinc_prank famsize afqt3) d(1) dstar(0) yreg(regress) cxd cxm} {p_end}

{pstd} percentile bootstrap CIs with 1000 replications, single mediator, all two-way interactions, printing outcome models: {p_end}
 
{phang2}{cmd:. impmed std_cesd_age40 ever_unemp_age3539, dvar(att22) cvars(female black hispan paredu parprof parinc_prank famsize afqt3) d(1) dstar(0) yreg(regress) cxd cxm reps(1000) detail}  {p_end}

{pstd} percentile bootstrap CIs with default settings, multiple mediators: {p_end}
 
{phang2}{cmd:. impmed std_cesd_age40 ever_unemp_age3539 log_faminc_adj_age3539, dvar(att22) cvars(female black hispan paredu parprof parinc_prank famsize afqt3) d(1) dstar(0) yreg(regress)} {p_end}

{title:Saved results}

{pstd}{cmd:impmed} saves the following results in {cmd:e()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}matrix containing direct, indirect, and total effect estimates{p_end}


{title:Author}

{pstd}Geoffrey T. Wodtke {break}
Department of Sociology{break}
University of Chicago{p_end}

{phang}Email: wodtke@uchicago.edu


{title:References}

{pstd}Wodtke, GT and X Zhou. Causal Mediation Analysis. In preparation. {p_end}

{title:Also see}

{psee}
Help: {manhelp regress R}, {manhelp logit R}, {manhelp bootstrap R}
{p_end}
