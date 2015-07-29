From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Jul 2015 21:44:56 +0000
Subject: [Intel-wired-lan] [e1000-patches][net-next PATCH S8 08/15]
	i40e: Fix comment for	ethtool diagnostic link test
In-Reply-To: <68C85B5FC2FE974B87244D7222BC92783EA1EB94@ORSMSX102.amr.corp.intel.com>
References: <1436466416-95687-1-git-send-email-catherine.sullivan@intel.com>
 <1436466416-95687-8-git-send-email-catherine.sullivan@intel.com>
 <68C85B5FC2FE974B87244D7222BC92783EA1EB94@ORSMSX102.amr.corp.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE7F0@ORSMSX104.amr.corp.intel.com>
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
> > Subject: [e1000-patches][net-next PATCH S8 08/15] i40e: Fix comment
> > for ethtool diagnostic link test
> >
> > From: Greg Rose <gregory.v.rose@intel.com>
> >
> > The existing comment is incorrect.  Add new comment to point out that
> > the PF reset does not affect link but if the reset is changed to a
> > different type that does affect link then the link test would need to
> > be moved to before the reset.
> >
> > Reported-by: Jeremiah Kyle <jeremiah.kyle@intel.com>
> > Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
> > Change-ID: I28d786f46e9465860babdee61c1dba51016464df
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
