From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Jul 2015 21:43:25 +0000
Subject: [Intel-wired-lan] [e1000-patches][net-next PATCH S8 12/15]
 i40e: Remove redundant and	unneeded messages
In-Reply-To: <68C85B5FC2FE974B87244D7222BC92783EA1EB6B@ORSMSX102.amr.corp.intel.com>
References: <1436466416-95687-1-git-send-email-catherine.sullivan@intel.com>
 <1436466416-95687-12-git-send-email-catherine.sullivan@intel.com>
 <68C85B5FC2FE974B87244D7222BC92783EA1EB6B@ORSMSX102.amr.corp.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE7C2@ORSMSX104.amr.corp.intel.com>
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
> > Subject: [e1000-patches][net-next PATCH S8 12/15] i40e: Remove
> > redundant and unneeded messages
> >
> > From: Greg Rose <gregory.v.rose@intel.com>
> >
> > The kernel notifies all VXLAN capable registered drivers, i.e. any
> > driver that implements ndo_add_vxlan_port(), of the addition of a port
> > so that the driver can track which ports are in use.  There's no need
> > to log this - it just fills the system log with useless and irksome noise.
> >
> > Also, when failing to init SR-IOV interfaces the driver was printing
> > the same message twice. Just remove the inner printk and let the outer
> > message catch enable as well as the other failures.
> >
> > Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
> > Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> > Change-ID: Id5ecb1d425c2a357ee2bc1635dab24553831dade
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_main.c        | 2 --
> >  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 --
> >  2 files changed, 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
