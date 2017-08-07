From: Brady, Alan <alan.brady@intel.com>
Date: Mon, 7 Aug 2017 17:31:28 +0000
Subject: [Intel-wired-lan] [next PATCH S78-V4 08/12] i40evf: Enable VF
 to request an alternate queue allocation
In-Reply-To: <afaabd4a-324e-ab62-3d5a-6170238eb74d@oracle.com>
References: <20170804135222.46684-1-alice.michael@intel.com>
 <20170804135222.46684-8-alice.michael@intel.com>
 <afaabd4a-324e-ab62-3d5a-6170238eb74d@oracle.com>
Message-ID: <C8326AE922E1A04D91DF73B4913A8DCB2CA32739@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of
> Shannon Nelson
> Sent: Monday, August 7, 2017 10:19 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [next PATCH S78-V4 08/12] i40evf: Enable VF to
> request an alternate queue allocation
> 
> On 8/4/2017 6:52 AM, Alice Michael wrote:
> > From: Alan Brady <alan.brady@intel.com>
> >
> > Currently the VF gets a default number of allocated queues from HW on
> > init and it could choose to enable or disable those allocated queues.
> > This makes it such that the VF can request more or less underlying
> > allocated queues from the PF.
> >
> > First the VF negotiates the number of queues it wants that can be
> > supported by the PF and if successful asks for a reset.  During reset
> > the PF will reallocate the HW queues for the VF and will then remap
> > the new queues.
> >
> > Signed-off-by: Alan Brady <alan.brady@intel.com>
> > ---
> >   drivers/net/ethernet/intel/i40evf/i40evf.h         |  4 +
> >   drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 38 ++++++++-
> >   drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 94
> ++++++++++++++++++++--
> >   .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 44 +++++++++-
> >   4 files changed, 173 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h
> > b/drivers/net/ethernet/intel/i40evf/i40evf.h
> > index a1af9b1..de0af52 100644
> > --- a/drivers/net/ethernet/intel/i40evf/i40evf.h
> > +++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
> > @@ -102,6 +102,7 @@ struct i40e_vsi {
> >   #define I40E_TX_CTXTDESC(R, i) \
> >   	(&(((struct i40e_tx_context_desc *)((R)->desc))[i]))
> >   #define MAX_QUEUES 16
> > +#define I40EVF_MAX_REQ_QUEUES 4
> 
> Why can you only request 4 queues if a VF can have up to 16 queues?
> 

Hey Shannon,

Thanks for the feedback.  So the differentiation here comes down to vectors.  The hardware can support up to 16 queues for a VF, but currently we're limited to 4 traffic vectors (+1 misc vector).  So we want to limit the user's ability to request more queues than that as it provides no benefit to have more queues than vectors with just RSS.  However, there are other features which can use more than 4 queues and the differentiation should become clearer with future patches.

> [...]

-ATB
