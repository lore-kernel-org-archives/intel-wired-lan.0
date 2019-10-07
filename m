From: Joe Perches <joe@perches.com>
Date: Mon, 07 Oct 2019 13:48:00 -0700
Subject: [Intel-wired-lan] i40e_pto.c: Odd use of strlcpy converted from
 strncpy
In-Reply-To: <a00c9af7d24ac0dd6af8698c9e545591392720fe.camel@intel.com>
References: <edf91d8284a2a19d956eb8b7e8b6c4984ceaa1ab.camel@perches.com>
 <a00c9af7d24ac0dd6af8698c9e545591392720fe.camel@intel.com>
Message-ID: <02fe65d8989ef1d030cf31c7134c574a242afc17.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2019-10-07 at 13:44 -0700, Jeff Kirsher wrote:
> On Sun, 2019-10-06 at 10:19 -0700, Joe Perches wrote:
> > This got converted from strncpy to strlcpy but it's
> > now not necessary to use one character less than the
> > actual size.
> > 
> > Perhaps the sizeof() - 1 is now not correct and it
> > should use strscpy and a normal sizeof.
[]
> You are also missing you signed-off-by: and Fixes:, I can get your
> change under test in the meantime to confirm your fix.

I didn't sign off as all I intended was to bring it
to your attention.  The diff is just the simplest way.
It's trivial if it's a defect.

> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_ptp.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > index 9bf1ad4319f5..627b1c02bb4b 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > @@ -700,8 +700,8 @@ static long i40e_ptp_create_clock(struct i40e_pf
> > *pf)
> >  	if (!IS_ERR_OR_NULL(pf->ptp_clock))
> >  		return 0;
> >  
> > -	strlcpy(pf->ptp_caps.name, i40e_driver_name,
> > -		sizeof(pf->ptp_caps.name) - 1);
> > +	strscpy(pf->ptp_caps.name, i40e_driver_name, sizeof(pf-
> > > ptp_caps.name));
> > +
> >  	pf->ptp_caps.owner = THIS_MODULE;
> >  	pf->ptp_caps.max_adj = 999999999;
> >  	pf->ptp_caps.n_ext_ts = 0;
> > 
> > 

