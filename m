From: Jason Gunthorpe <jgg@nvidia.com>
Date: Fri, 24 Sep 2021 11:10:04 -0300
Subject: [Intel-wired-lan] [PATCH RESEND net] ice: Correctly deal with
 PFs that do not support RDMA
In-Reply-To: <20210909151223.572918-1-david.m.ertman@intel.com>
References: <20210909151223.572918-1-david.m.ertman@intel.com>
Message-ID: <20210924141004.GA1237721@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Sep 09, 2021 at 08:12:23AM -0700, Dave Ertman wrote:
> There are two cases where the current PF does not support RDMA
> functionality.  The first is if the NVM loaded on the device is set
> to not support RDMA (common_caps.rdma is false).  The second is if
> the kernel bonding driver has included the current PF in an active
> link aggregate.
> 
> When the driver has determined that this PF does not support RDMA, then
> auxiliary devices should not be created on the auxiliary bus.  Without
> a device on the auxiliary bus, even if the irdma driver is present, there
> will be no RDMA activity attempted on this PF.
> 
> Currently, in the reset flow, an attempt to create auxiliary devices is
> performed without regard to the ability of the PF.  There needs to be a
> check in ice_aux_plug_dev (as the central point that creates auxiliary
> devices) to see if the PF is in a state to support the functionality.
> 
> When disabling and re-enabling RDMA due to the inclusion/removal of the PF
> in a link aggregate, we also need to set/clear the bit which controls
> auxiliary device creation so that a reset recovery in a link aggregate
> situation doesn't try to create auxiliary devices when it shouldn't.
> 
> Fixes: f9f5301e7e2d ("ice: Register auxiliary device to provide RDMA")
> Reported-by: Yongxin Liu <yongxin.liu@windriver.com>
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>  drivers/net/ethernet/intel/ice/ice.h     | 2 ++
>  drivers/net/ethernet/intel/ice/ice_idc.c | 6 ++++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> index eadcb9958346..3c4f08d20414 100644
> +++ b/drivers/net/ethernet/intel/ice/ice.h
> @@ -695,6 +695,7 @@ static inline void ice_set_rdma_cap(struct ice_pf *pf)
>  {
>  	if (pf->hw.func_caps.common_cap.rdma && pf->num_rdma_msix) {
>  		set_bit(ICE_FLAG_RDMA_ENA, pf->flags);
> +		set_bit(ICE_FLAG_AUX_ENA, pf->flags);
>  		ice_plug_aux_dev(pf);

I agree with Leon, there shouldn't be a flag for "aux en". aux is
enabled when a device on the aux bus is required. It should all be
rdma en, which already seems to have a bit.

Th only existing place that uses aux_ena immediately calls

		err = ice_init_rdma(pf);

So I'd just delete the whole thing and use rdma_ena. Frankly it looks
structured confusingly, the mlx implementation is better where this is
one function that synchronizes the aux bus with the current state of
the driver - adding/removing as required

Jason
