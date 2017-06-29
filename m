From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 29 Jun 2017 17:20:43 +0000
Subject: [Intel-wired-lan] [next PATCH S75-V2 02/12] i40e: use
 cpumask_copy instead of direct assignment
In-Reply-To: <20170629083643.82018-2-alice.michael@intel.com>
References: <20170629083643.82018-1-alice.michael@intel.com>
 <20170629083643.82018-2-alice.michael@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB58829D6867@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ACK

> -----Original Message-----
> From: Michael, Alice
> Sent: Thursday, June 29, 2017 1:37 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-lan at lists.osuosl.org
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>
> Subject: [next PATCH S75-V2 02/12] i40e: use cpumask_copy instead of direct
> assignment
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> According to the header file cpumask.h, we shouldn't be directly copying
> a cpumask_t, since its a bitmap and might not be copied correctly. Lets
> use the provided cpumask_copy() function instead.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 2 +-
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 998ad96..837d434 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -3450,7 +3450,7 @@ static void i40e_irq_affinity_notify(struct
> irq_affinity_notify *notify,
>  	struct i40e_q_vector *q_vector =
>  		container_of(notify, struct i40e_q_vector, affinity_notify);
> 
> -	q_vector->affinity_mask = *mask;
> +	cpumask_copy(&q_vector->affinity_mask, mask);
>  }
> 
>  /**
> diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> index ef55f71..755f60f 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> +++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> @@ -520,7 +520,7 @@ static void i40evf_irq_affinity_notify(struct
> irq_affinity_notify *notify,
>  	struct i40e_q_vector *q_vector =
>  		container_of(notify, struct i40e_q_vector, affinity_notify);
> 
> -	q_vector->affinity_mask = *mask;
> +	cpumask_copy(&q_vector->affinity_mask, mask);
>  }
> 
>  /**
> --
> 2.9.3

