From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Mon, 1 Nov 2021 10:20:47 +0000
Subject: [Intel-wired-lan] [PATCH net v2] ice: Fix not stopping Tx
 queues for VFs
In-Reply-To: <20210909213809.27461-1-brett.creeley@intel.com>
References: <20210909213809.27461-1-brett.creeley@intel.com>
Message-ID: <DM8PR11MB5621ACCA9DA616426E8EE369AB8A9@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Brett Creeley
> Sent: czwartek, 9 wrze?nia 2021 23:38
> To: intel-wired-lan at lists.osuosl.org
> Cc: Patynowski, PrzemyslawX <przemyslawx.patynowski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v2] ice: Fix not stopping Tx queues for
> VFs
> 
> When a VF is removed and/or reset its Tx queues need to be stopped from
> the PF. This is done by calling the ice_dis_vf_qs() function, which calls
> ice_vsi_stop_lan_tx_rings(). Currently
> ice_dis_vf_qs() is protected by the VF state bit ICE_VF_STATE_QS_ENA.
> Unfortunately, this is causing the Tx queues to not be disabled in some cases
> and when the VF tries to re-enable/reconfigure its Tx queues over virtchnl
> the op is failing. This is because a VF can be reset and/or removed before the
> ICE_VF_STATE_QS_ENA bit is set, but the Tx queues were already configured
> via ice_vsi_cfg_single_txq() in the VIRTCHNL_OP_CONFIG_VSI_QUEUES op.
> However, the ICE_VF_STATE_QS_ENA bit is set on a successful
> VIRTCHNL_OP_ENABLE_QUEUES, which will always happen after the
> VIRTCHNL_OP_CONFIG_VSI_QUEUES op.
> 
> This was causing the following error message when loading the ice driver,
> creating VFs, and modifying VF trust in an endless loop:
> 
> [35274.192484] ice 0000:88:00.0: Failed to set LAN Tx queue context, error:
> ICE_ERR_PARAM [35274.193074] ice 0000:88:00.0: VF 0 failed opcode 6,
> retval: -5 [35274.193640] iavf 0000:88:01.0: PF returned error -5
> (IAVF_ERR_PARAM) to our request 6
> 
> Fix this by always calling ice_dis_vf_qs() and silencing the error message in
> ice_vsi_stop_tx_ring() since the calling code ignores the return anyway. Also,
> all other places that call ice_vsi_stop_tx_ring() catch the error, so this doesn't
> affect those flows since there was no change to the values the function
> returns.
> 
> Other solutions were considered (i.e. tracking which VF queues had been
> "started/configured" in VIRTCHNL_OP_CONFIG_VSI_QUEUES, but it seemed
> more complicated than it was worth. This solution also brings in the chance
> for other unexpected conditions due to invalid state bit checks.
> So, the proposed solution seemed like the best option since there is no harm
> in failing to stop Tx queues that were never started.
> 
> This issue can be seen using the following commands:
> 
> for i in {0..50}; do
>         rmmod ice
>         modprobe ice
> 
>         sleep 1
> 
>         echo 1 > /sys/class/net/ens785f0/device/sriov_numvfs
>         echo 1 > /sys/class/net/ens785f1/device/sriov_numvfs
> 
>         ip link set ens785f1 vf 0 trust on
>         ip link set ens785f0 vf 0 trust on
> 
>         sleep 2
> 
>         echo 0 > /sys/class/net/ens785f0/device/sriov_numvfs
>         echo 0 > /sys/class/net/ens785f1/device/sriov_numvfs
>         sleep 1
>         echo 1 > /sys/class/net/ens785f0/device/sriov_numvfs
>         echo 1 > /sys/class/net/ens785f1/device/sriov_numvfs
> 
>         ip link set ens785f1 vf 0 trust on
>         ip link set ens785f0 vf 0 trust on done
> 
> Fixes: 77ca27c41705 ("ice: add support for
> virtchnl_queue_select.[tx|rx]_queues bitmap")
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
> v2: Update Fixes tag
> 
>  drivers/net/ethernet/intel/ice/ice_base.c        | 2 +-
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 6 ++----
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_base.c
> b/drivers/net/ethernet/intel/ice/ice_base.c
> index c36057efc7ae..f74610442bda 100644
> --- a/drivers/net/ethernet/intel/ice/ice_base.c
> +++ b/drivers/net/ethernet/intel/ice/ice_base.c

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
