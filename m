From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Thu, 28 Oct 2021 06:44:12 +0000
Subject: [Intel-wired-lan] [PATCH net v2] iavf: Fix return of set the
 new channel count
In-Reply-To: <20210209115938.2266-1-mateusz.palczewski@intel.com>
References: <20210209115938.2266-1-mateusz.palczewski@intel.com>
Message-ID: <DM8PR11MB56217FB4207F2A9D28D845FEAB869@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Palczewski
> Sent: wtorek, 9 lutego 2021 13:00
> To: intel-wired-lan at lists.osuosl.org
> Cc: Palczewski, Mateusz <mateusz.palczewski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v2] iavf: Fix return of set the new
> channel count
> 
> Fixed return correct code from set the new channel count.
> Implemented by check if reset is done in appropriate time.
> This solution give a extra time to pf for reset vf in case when user want set
> new channel count for all vfs.
> Without this patch it is possible to return misleading output code to user and
> vf reset not to be correctly performed by pf.
> 
> Fixes: 5520deb15326("iavf: Enable support for up to 16 queues")
> Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
> v2:
>  - added missing define in iavf.h file
> 
>  drivers/net/ethernet/intel/iavf/iavf.h         |  1 +
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h
> b/drivers/net/ethernet/intel/iavf/iavf.h
> index bda2a90..09e5b9c 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> @@ -220,6 +220,7 @@ struct iavf_cloud_filter {
>  	bool add;		/* filter needs to be added */
>  };
> 
> +#define IAVF_RESET_WAIT_COUNT 500
>  #define IAVF_RESET_WAIT_MS 10
>  #define IAVF_RESET_WAIT_DETECTED_COUNT 500  #define
> IAVF_RESET_WAIT_COMPLETE_COUNT 2000 diff --git
> a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> index 3ebfef7..d9ed4d4 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> @@ -1522,6 +1522,7 @@ static int iavf_set_channels(struct net_device
> *netdev,  {
>  	struct iavf_adapter *adapter = netdev_priv(netdev);
>  	u32 num_req = ch->combined_count;
> +	int i;
> 
>  	if ((adapter->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_ADQ)
> &&
>  	    adapter->num_tc) {
> @@ -1544,6 +1545,20 @@ static int iavf_set_channels(struct net_device
> *netdev,
>  	adapter->num_req_queues = num_req;
>  	adapter->flags |= IAVF_FLAG_REINIT_ITR_NEEDED;
>  	iavf_schedule_reset(adapter);
> +
> +	/* wait for the reset is done */
> +	for (i = 0; i < IAVF_RESET_WAIT_COUNT; i++) {
> +		msleep(IAVF_RESET_WAIT_MS);
> +		if (adapter->flags & IAVF_FLAG_RESET_PENDING)
> +			continue;
> +		break;
> +	}
> +	if (i == IAVF_RESET_WAIT_COUNT) {
> +		adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
> +		adapter->num_active_queues = num_req;
> +		return -EOPNOTSUPP;
> +	}
> +
>  	return 0;
>  }
> 

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
