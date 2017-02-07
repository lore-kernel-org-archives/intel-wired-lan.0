From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 7 Feb 2017 17:46:14 +0000
Subject: [Intel-wired-lan] [FIXUP PATCH 2/2] fixup! i40e: Add support
 for exposing VF port statistics via VFPR netdev on the host
In-Reply-To: <58996A9B.1060802@intel.com>
References: <20170206223840.30938-1-jacob.e.keller@intel.com>
 <20170206223840.30938-4-jacob.e.keller@intel.com>
 <58996A9B.1060802@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB5857D6DCA2@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Samudrala, Sridhar
> Sent: Monday, February 06, 2017 10:35 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>; Intel Wired LAN <intel-wired-
> lan at lists.osuosl.org>
> Subject: Re: [Intel-wired-lan] [FIXUP PATCH 2/2] fixup! i40e: Add support for
> exposing VF port statistics via VFPR netdev on the host
> 
> On 2/6/2017 2:38 PM, Jacob Keller wrote:
> > This fixes a compiler warning in commit abc0e7634722 ("i40e: Add support
> > for exposing VF port statistics via VFPR netdev on the host",
> > 2017-01-31) which is caused by a function that should have been marked
> > as static.
> >
> > Jeff, please squash this patch into the given commit, or have the
> > original author re-roll his patch to fix the warning.
> >
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Acked-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> 
> Jeff, Along with this patch, can you also squash this patch into this
> commit to fix percpu related
> warning messages.

Thanks!

Regards,
Jake

> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
> index 52ba9d5..7ddce0d 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
> @@ -85,7 +85,7 @@ struct vfpr_pcpu_stats {
>   struct i40e_vfpr_netdev_priv {
>          struct metadata_dst *vfpr_dst;
>          struct i40e_vf *vf;
> -       struct vfpr_pcpu_stats *vfpr_stats;
> +       struct vfpr_pcpu_stats __percpu *vfpr_stats;
>   };
> 
>   /* VF information structure */
> 
> 
> > ---
> >   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> > index 9efecff9c535..2686ddd65618 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
> > @@ -1062,7 +1062,7 @@ static int i40e_vfpr_netdev_stop(struct net_device
> *dev)
> >    *
> >    * Fills the hw statistics from the VSI corresponding to the associated VFPR
> >    **/
> > -void
> > +static void
> >   i40e_vfpr_netdev_get_stats64(struct net_device *netdev,
> >   			     struct rtnl_link_stats64 *stats)
> >   {

