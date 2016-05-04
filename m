From: Wyborny, Carolyn <carolyn.wyborny@intel.com>
Date: Wed, 4 May 2016 15:55:17 +0000
Subject: [Intel-wired-lan] [next PATCH S36 03/12] i40e: Implement the
 API	function for aq_set_switch_config
In-Reply-To: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D5954@ORSMSX104.amr.corp.intel.com>
References: <1462313600-3123-1-git-send-email-bimmy.pujari@intel.com>
 <1462313600-3123-4-git-send-email-bimmy.pujari@intel.com>
 <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D5954@ORSMSX104.amr.corp.intel.com>
Message-ID: <9BBC4E0CF881AA4299206E2E1412B626501C7EFF@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bowers, AndrewX
> Sent: Wednesday, May 04, 2016 8:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [next PATCH S36 03/12] i40e: Implement the API
> function for aq_set_switch_config
> 
> > -----Original Message-----
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> > Behalf Of Bimmy Pujari
> > Sent: Tuesday, May 03, 2016 3:13 PM
> > To: intel-wired-lan at lists.osuosl.org
> > Subject: [Intel-wired-lan] [next PATCH S36 03/12] i40e: Implement the API
> > function for aq_set_switch_config
> >
> > From: Shannon Nelson <shannon.nelson@intel.com>
> >
> > Add the support code for calling the AdminQ API call aq_set_switch_config
> >
> > Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> > ---
> > Testing Hints : Apply and compile cleanly
> >
> >  drivers/net/ethernet/intel/i40e/i40e_common.c    | 29
> > ++++++++++++++++++++++++
> >  drivers/net/ethernet/intel/i40e/i40e_prototype.h |  4 ++++
> >  2 files changed, 33 insertions(+)
> 
> Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
> Code changes present, compiles cleanly

We need to make sure we have the patch that actually uses this included in the patches sent upstream.  

Thanks,

Carolyn
