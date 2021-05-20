From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Thu, 20 May 2021 07:53:53 +0000
Subject: [Intel-wired-lan] [PATCH net v2] ixgbe: fix large MTU request
 from VF
In-Reply-To: <20210513084253.19964-1-mateusz.palczewski@intel.com>
References: <20210513084253.19964-1-mateusz.palczewski@intel.com>
Message-ID: <CY4PR11MB15763FA78C3CA0E2C68E6423AB2A9@CY4PR11MB1576.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Palczewski, Mateusz <mateusz.palczewski@intel.com>
> Sent: czwartek, 13 maja 2021 10:43
> To: intel-wired-lan at lists.osuosl.org
> Cc: Wyborny, Carolyn <carolyn.wyborny@intel.com>; Jankowski, Konrad0
> <konrad0.jankowski@intel.com>; Rybak, Eryk Roch
> <eryk.roch.rybak@intel.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; Skajewski, PiotrX
> <piotrx.skajewski@intel.com>; Palczewski, Mateusz
> <mateusz.palczewski@intel.com>
> Subject: [PATCH net v2] ixgbe: fix large MTU request from VF
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Check that the MTU value requested by the VF is in the supported range of
> MTUs before attempting to set the VF large packet enable, otherwise reject
> the request. This also avoids unnecessary register updates in the case of the
> 82599 controller.
> 
> Fixes: 872844ddb9e4 ("ixgbe: Enable jumbo frames support w/ SR-IOV")
> Co-developed-by: Piotr Skajewski <piotrx.skajewski@intel.com>
> Signed-off-by: Piotr Skajewski <piotrx.skajewski@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Co-developed-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  v2: Changed hard coded 68 value to ETH_MIN_MTU
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> index 988db46..75921cd 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> @@ -467,12 +467,16 @@ static int ixgbe_set_vf_vlan(struct ixgbe_adapter
> *adapter, int add, int vid,
>  	return err;
>  }
> 
> -static s32 ixgbe_set_vf_lpe(struct ixgbe_adapter *adapter, u32 *msgbuf,
> u32 vf)
> +static int ixgbe_set_vf_lpe(struct ixgbe_adapter *adapter, u32
> +max_frame, u32 vf)
>  {
>  	struct ixgbe_hw *hw = &adapter->hw;
> -	int max_frame = msgbuf[1];
>  	u32 max_frs;
> 
> +	if (max_frame < ETH_MIN_MTU || max_frame >
> IXGBE_MAX_JUMBO_FRAME_SIZE) {
> +		e_err(drv, "VF max_frame %d out of range\n", max_frame);
> +		return -EINVAL;
> +	}
> +
>  	/*
>  	 * For 82599EB we have to keep all PFs and VFs operating with
>  	 * the same max_frame value in order to avoid sending an oversize
> @@ -533,12 +537,6 @@ static s32 ixgbe_set_vf_lpe(struct ixgbe_adapter
> *adapter, u32 *msgbuf, u32 vf)
>  		}
>  	}
> 
> -	/* MTU < 68 is an error and causes problems on some kernels */
> -	if (max_frame > IXGBE_MAX_JUMBO_FRAME_SIZE) {
> -		e_err(drv, "VF max_frame %d out of range\n", max_frame);
> -		return -EINVAL;
> -	}
> -
>  	/* pull current max frame size from hardware */
>  	max_frs = IXGBE_READ_REG(hw, IXGBE_MAXFRS);
>  	max_frs &= IXGBE_MHADD_MFS_MASK;
> @@ -1249,7 +1247,7 @@ static int ixgbe_rcv_msg_from_vf(struct
> ixgbe_adapter *adapter, u32 vf)
>  		retval = ixgbe_set_vf_vlan_msg(adapter, msgbuf, vf);
>  		break;
>  	case IXGBE_VF_SET_LPE:
> -		retval = ixgbe_set_vf_lpe(adapter, msgbuf, vf);
> +		retval = ixgbe_set_vf_lpe(adapter, msgbuf[1], vf);
>  		break;
>  	case IXGBE_VF_SET_MACVLAN:
>  		retval = ixgbe_set_vf_macvlan_msg(adapter, msgbuf, vf);
> --
> 2.18.1

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
