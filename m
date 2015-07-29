From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Jul 2015 21:41:57 +0000
Subject: [Intel-wired-lan] [e1000-patches][net-next PATCH S8 13/15]
	i40e/i40evf: add	VIRTCHNL_VF_OFFLOAD flag
In-Reply-To: <68C85B5FC2FE974B87244D7222BC92783EA1EB55@ORSMSX102.amr.corp.intel.com>
References: <1436466416-95687-1-git-send-email-catherine.sullivan@intel.com>
 <1436466416-95687-13-git-send-email-catherine.sullivan@intel.com>
 <68C85B5FC2FE974B87244D7222BC92783EA1EB55@ORSMSX102.amr.corp.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE791@ORSMSX104.amr.corp.intel.com>
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
> > Subject: [e1000-patches][net-next PATCH S8 13/15] i40e/i40evf: add
> > VIRTCHNL_VF_OFFLOAD flag
> >
> > From: Anjali Singhai Jain <anjali.singhai@intel.com>
> >
> > Add virtual channel offload capability to support RX polling mode in the VF.
> >
> > Signed-off-by: Jingjing Wu <jingjing.wu@intel.com>
> > Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> > Change-ID: Ib643ae2a7506dfc75fc489fc207493fabefa4832
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_register.h    |  7 +++++++
> >  drivers/net/ethernet/intel/i40e/i40e_virtchnl.h    |  1 +
> >  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 12 ++++++++++++
> > drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h  |  1 +
> >  4 files changed, 21 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
