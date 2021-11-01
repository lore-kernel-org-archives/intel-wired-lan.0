From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Mon, 1 Nov 2021 10:22:00 +0000
Subject: [Intel-wired-lan] [PATCH net v2] ice: Fix race conditions
 between virtchnl handling and VF ndo ops
In-Reply-To: <20210909213809.27461-2-brett.creeley@intel.com>
References: <20210909213809.27461-1-brett.creeley@intel.com>
 <20210909213809.27461-2-brett.creeley@intel.com>
Message-ID: <DM8PR11MB5621D1A1660CAAD1E9780A8CAB8A9@DM8PR11MB5621.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net v2] ice: Fix race conditions between
> virtchnl handling and VF ndo ops
> 
> The VF can be configured via the PF's ndo ops at the same time the PF is
> receiving/handling virtchnl messages. This has many issues, with one of them
> being the ndo op could be actively resetting a VF (i.e.
> resetting it to the default state and deleting/re-adding the VF's VSI) while a
> virtchnl message is being handled. The following error was seen because a VF
> ndo op was used to change a VF's trust setting while the
> VIRTCHNL_OP_CONFIG_VSI_QUEUES was ongoing:
> 
> [35274.192484] ice 0000:88:00.0: Failed to set LAN Tx queue context, error:
> ICE_ERR_PARAM [35274.193074] ice 0000:88:00.0: VF 0 failed opcode 6,
> retval: -5 [35274.193640] iavf 0000:88:01.0: PF returned error -5
> (IAVF_ERR_PARAM) to our request 6
> 
> Fix this by making sure the virtchnl handling and VF ndo ops that trigger VF
> resets cannot run concurrently. This is done by adding a struct mutex
> cfg_lock to each VF structure. For VF ndo ops, the mutex will be locked
> around the critical operations and VFR. Since the ndo ops will trigger a VFR,
> the virtchnl thread will use mutex_trylock(). This is done because if any other
> thread (i.e. VF ndo op) has the mutex, then that means the current VF
> message being handled is no longer valid, so just ignore it.
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
> Fixes: 7c710869d64e ("ice: Add handlers for VF netdevice operations")
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
> v2: Update Fixes tag
> 
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 25 +++++++++++++++++++
> .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  5 ++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> index e93430ab37f1..bf6bffbc2173 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
> @@ -647,6 +647,8 @@ void ice_free_vfs(struct ice_pf *pf)

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
