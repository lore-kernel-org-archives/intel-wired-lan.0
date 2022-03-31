From: Leon Romanovsky <leon@kernel.org>
Date: Thu, 31 Mar 2022 10:45:10 +0300
Subject: [Intel-wired-lan] [PATCH net] ixgbe: ensure IPsec VF<->PF
 compatibility
In-Reply-To: <b201a3ed-5698-4e91-adc9-34c938e43668@pensando.io>
References: <3702fad8a016170947da5f3c521a9251cf0f4a22.1648637865.git.leonro@nvidia.com>
 <b201a3ed-5698-4e91-adc9-34c938e43668@pensando.io>
Message-ID: <YkVcBgac41VjNBd7@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Mar 30, 2022 at 09:13:21AM -0700, Shannon Nelson wrote:
> On 3/30/22 4:01 AM, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > The VF driver can forward any IPsec flags and such makes the function
> > is not extendable and prone to backward/forward incompatibility.
> > 
> > If new software runs on VF, it won't know that PF configured something
> > completely different as it "knows" only XFRM_OFFLOAD_INBOUND flag.
> > 
> > Fixes: eda0333ac293 ("ixgbe: add VF IPsec management")
> > Reviewed-by: Raed Salem <raeds@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> > There is no simple fix for this VF/PF incompatibility as long as FW
> > doesn't filter/decline unsupported options when convey mailbox from VF
> > to PF.
> > ---
> >   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> > index e596e1a9fc75..236f244e3f65 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
> > @@ -903,7 +903,9 @@ int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
> >   	/* Tx IPsec offload doesn't seem to work on this
> >   	 * device, so block these requests for now.
> >   	 */
> > -	if (!(sam->flags & XFRM_OFFLOAD_INBOUND)) {
> > +	sam->flags = sam->flags & ~XFRM_OFFLOAD_IPV6;
> > +	if (!(sam->flags & XFRM_OFFLOAD_INBOUND) ||
> > +	    sam->flags & ~XFRM_OFFLOAD_INBOUND) {
> 
> So after stripping the IPV6 flag, you're checking to be sure that INBOUND is
> the only flag enabled, right?
> Could you use
> ??? if (sam->flags != XFRM_OFFLOAD_INBOUND) {
> instead?

Sure, I'll send new version soon.

Thanks

> 
> sln
> 
> >   		err = -EOPNOTSUPP;
> >   		goto err_out;
> >   	}
> 
