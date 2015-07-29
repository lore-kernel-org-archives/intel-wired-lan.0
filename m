From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Jul 2015 21:43:57 +0000
Subject: [Intel-wired-lan] [e1000-patches][net-next PATCH S8 11/15]
 i40evf: Remove PF specific	register definitions from the VF
In-Reply-To: <68C85B5FC2FE974B87244D7222BC92783EA1EB84@ORSMSX102.amr.corp.intel.com>
References: <1436466416-95687-1-git-send-email-catherine.sullivan@intel.com>
 <1436466416-95687-11-git-send-email-catherine.sullivan@intel.com>
 <68C85B5FC2FE974B87244D7222BC92783EA1EB84@ORSMSX102.amr.corp.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE7CE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> > -----Original Message-----
> > From: e1000-patches-bounces at isotope.jf.intel.com [mailto:e1000-
> patches-
> > bounces at isotope.jf.intel.com] On Behalf Of Sullivan, Catherine
> > Sent: Thursday, July 09, 2015 11:27 AM
> > To: e1000-patches at isotope.jf.intel.com
> > Subject: [e1000-patches][net-next PATCH S8 11/15] i40evf: Remove PF
> > specific register definitions from the VF
> >
> > From: Anjali Singhai Jain <anjali.singhai@intel.com>
> >
> > There were quite a few issues when the wrong defines were getting used
> > in the VF driver. This patch fixes the code where PF driver registers
> > were getting used for VF driver, and also removes the registers that are
> > not being used from the VF register file.
> >
> > Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> > Acked-by: Mitch Williams <mitch.a.williams@intel.com>
> > Change-ID: If116a9730112950d006eb8ec763998fc914cc839
> > ---
> >  drivers/net/ethernet/intel/i40evf/i40e_adminq.c   |   17 +-
> >  drivers/net/ethernet/intel/i40evf/i40e_common.c   |    2 +-
> >  drivers/net/ethernet/intel/i40evf/i40e_register.h | 3093 ---------------------
> >  3 files changed, 4 insertions(+), 3108 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
