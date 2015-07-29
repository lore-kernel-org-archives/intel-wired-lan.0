From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Jul 2015 21:46:52 +0000
Subject: [Intel-wired-lan] [e1000-patches][net-next PATCH S8 03/15]
 i40e/i40evf: Move helper	functions to a header file
In-Reply-To: <68C85B5FC2FE974B87244D7222BC92783EA1EBCC@ORSMSX102.amr.corp.intel.com>
References: <1436466416-95687-1-git-send-email-catherine.sullivan@intel.com>
 <1436466416-95687-3-git-send-email-catherine.sullivan@intel.com>
 <68C85B5FC2FE974B87244D7222BC92783EA1EBCC@ORSMSX102.amr.corp.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE830@ORSMSX104.amr.corp.intel.com>
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
> > Subject: [e1000-patches][net-next PATCH S8 03/15] i40e/i40evf: Move
> > helper functions to a header file
> >
> > From: Anjali Singhai Jain <anjali.singhai@intel.com>
> >
> > A new header file i40e_helper.h is added to both the PF and VF driver
> > with functions used by both drivers.
> >
> > Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> > Change-ID: I3c6daedc2ff6f32bc7624bf5eaef05899d35f28b
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_helper.h   | 102
> > ++++++++++++++++++++++++
> >  drivers/net/ethernet/intel/i40e/i40e_main.c     |  72 +----------------
> >  drivers/net/ethernet/intel/i40evf/i40e_helper.h | 102
> > ++++++++++++++++++++++++
> > drivers/net/ethernet/intel/i40evf/i40evf_main.c |  80
> > +------------------
> >  4 files changed, 206 insertions(+), 150 deletions(-)  create mode

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
