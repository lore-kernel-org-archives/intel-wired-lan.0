From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 3 Aug 2021 17:45:29 +0000
Subject: [Intel-wired-lan] [PATCH next-queue v1 1/3] igc: Use default
 cycle 'start' and 'end' values for queues
In-Reply-To: <1627916831-10144-2-git-send-email-aravindhan.gunasekaran@intel.com>
References: <1627916831-10144-1-git-send-email-aravindhan.gunasekaran@intel.com>
 <1627916831-10144-2-git-send-email-aravindhan.gunasekaran@intel.com>
Message-ID: <9a007e51b14139e1c6372f182f8a38d1d4dc662e.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2021-08-02 at 20:37 +0530, aravindhan.gunasekaran at intel.com
wrote:
> From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> 
> Sets default values for each queue cycle start and cycle end. This
> allows some simplification in the handling of these configurations as
> most TSN features in i225 require a cycle to be configured.
> 
> In i225, cycle start and end time is required to be programmed for
> CBS to work properly.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Aravindhan Gunasekaran <
> aravindhan.gunasekaran at intel.com>
> ---

<snip>

> @@ -5841,16 +5829,31 @@ static int igc_tsn_enable_launchtime(struct
> igc_adapter *adapter,
>  	return igc_tsn_offload_apply(adapter);
>  }
>  
> +static int igc_tsn_clear_schedule(struct igc_adapter *adapter)
> +{
> +	int i;
> +
> +	adapter->base_time = 0;
> +	adapter->cycle_time = NSEC_PER_SEC;
> +
> +	for (i = 0; i < IGC_MAX_TX_QUEUES; i++) {

Should this be using adapter->num_tx_queues? Otherwise, we can come
across this [1]?

> +		struct igc_ring *ring = adapter->tx_ring[i];
> +
> +		ring->start_time = 0;
> +		ring->end_time = NSEC_PER_SEC;
> +	}
> +
> +	return 0;
> +}

[1] https://patchwork.ozlabs.org/project/intel-wired-
lan/patch/20210722003403.69289-1-vinicius.gomes at intel.com/

