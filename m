From: Sullivan, Catherine <catherine.sullivan@intel.com>
Date: Tue, 29 Sep 2015 21:49:40 +0000
Subject: [Intel-wired-lan] [next PATCH S9 07/15] i40e: use qos
	field	consistently
In-Reply-To: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE4EC@ORSMSX104.amr.corp.intel.com>
References: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
 <1437684884-222825-8-git-send-email-catherine.sullivan@intel.com>
 <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE4EC@ORSMSX104.amr.corp.intel.com>
Message-ID: <E8A77B2FB54C194393A5C2A8E3ED167827A54B37@CRSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> > -----Original Message-----
> > From: Intel-wired-lan
> > [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of
> > Catherine Sullivan
> > Sent: Thursday, July 23, 2015 1:55 PM
> > To: intel-wired-lan at lists.osuosl.org
> > Subject: [Intel-wired-lan] [next PATCH S9 07/15] i40e: use qos field
> > consistently
> >
> > From: Mitch Williams <mitch.a.williams@intel.com>
> >
> > In i40e_ndo_set_vf_port_vlan, we were using the qos value
> > inconsistently, sometimes shifting it, sometimes not. Do the
> > shift-and- or operation correctly, once, and use the result consistently
> everywhere
> >     in the function.
> >
> > Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> > Change-ID: I46f062f3edc90a8a017ecec9137f4d1ab0ab9e41
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >
> Verified-by: Andrew Bowers <andrewx.bowers@intel.com>
> 
> Present in git log, code changes present in tree.

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

Already verified, but wasn't flagged as such in patchwork.

