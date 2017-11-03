From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Fri, 3 Nov 2017 13:12:46 -0700
Subject: [Intel-wired-lan] [next PATCH S82 9/9] i40e: Suppress
 compilation warning on kernels older than 3.12
In-Reply-To: <20171103110511.76793-9-alice.michael@intel.com>
References: <20171103110511.76793-1-alice.michael@intel.com>
 <20171103110511.76793-9-alice.michael@intel.com>
Message-ID: <de798a1b-1068-8118-1f48-c6bd4cca2dcd@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/3/2017 4:05 AM, Alice Michael wrote:
> From: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
> 
> In kernels before 3.12 the second parameter in netif_set_xps_queue
> function has no const qualifier. It is generating warning in older
> kernels. get_cpu_mask function always returns a pointer with const
> qualifier. Adding the cast is enough to remove compilation warning.
> 
> Signed-off-by: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
> ---
>   drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 8657ef6..1fe8099 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -3062,8 +3062,7 @@ static void i40e_config_xps_tx_ring(struct i40e_ring *ring)
>   		return;
>   
>   	cpu = cpumask_local_spread(ring->q_vector->v_idx, -1);
> -	netif_set_xps_queue(ring->netdev, get_cpu_mask(cpu),
> -			    ring->queue_index);
> +	netif_set_xps_queue(ring->netdev, get_cpu_mask(cpu), ring->queue_index);

I see no actual code change here, no cast as advertised.
sln

>   }
>   
>   /**
> 
