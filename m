From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Jul 2015 21:42:31 +0000
Subject: [Intel-wired-lan] [e1000-patches][net-next PATCH S8 14/15]
 i40e/i40evf: Cache the CEE	TLV status returned from firmware
In-Reply-To: <68C85B5FC2FE974B87244D7222BC92783EA1EB5D@ORSMSX102.amr.corp.intel.com>
References: <1436466416-95687-1-git-send-email-catherine.sullivan@intel.com>
 <1436466416-95687-14-git-send-email-catherine.sullivan@intel.com>
 <68C85B5FC2FE974B87244D7222BC92783EA1EB5D@ORSMSX102.amr.corp.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE7A1@ORSMSX104.amr.corp.intel.com>
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
> > Subject: [e1000-patches][net-next PATCH S8 14/15] i40e/i40evf: Cache
> > the CEE TLV status returned from firmware
> >
> > From: Neerav Parikh <neerav.parikh@intel.com>
> >
> > Store the CEE TLV status returned by firmware to allow drivers to dump
> > that for debug purposes.
> >
> > Signed-off-by: Neerav Parikh <neerav.parikh@intel.com>
> > Change-ID: Ie3c4cf8cebabee4f15e1e3fdc4fc8a68bbca40ee
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_dcb.c    | 4 ++++
> >  drivers/net/ethernet/intel/i40e/i40e_type.h   | 1 +
> >  drivers/net/ethernet/intel/i40evf/i40e_type.h | 1 +
> >  3 files changed, 6 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
