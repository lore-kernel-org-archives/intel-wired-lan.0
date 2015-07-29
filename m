From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Jul 2015 21:47:41 +0000
Subject: [Intel-wired-lan] [e1000-patches][net-next PATCH S8 01/15]
 i40e: Fix mismatched types	in comparison
In-Reply-To: <68C85B5FC2FE974B87244D7222BC92783EA1EBF5@ORSMSX102.amr.corp.intel.com>
References: <1436466416-95687-1-git-send-email-catherine.sullivan@intel.com>
 <68C85B5FC2FE974B87244D7222BC92783EA1EBF5@ORSMSX102.amr.corp.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE848@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> > -----Original Message-----
> > From: e1000-patches-bounces at isotope.jf.intel.com
> > [mailto:e1000-patches- bounces at isotope.jf.intel.com] On Behalf Of
> > Sullivan, Catherine
> > Sent: Thursday, July 09, 2015 11:27 AM
> > To: e1000-patches at isotope.jf.intel.com
> > Subject: [e1000-patches][net-next PATCH S8 01/15] i40e: Fix mismatched
> > types in comparison
> >
> > Add a le_to_CPU wrapper to fix mismatched types.
> >
> > Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
