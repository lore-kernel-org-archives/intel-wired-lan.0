From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 27 May 2022 09:56:56 -0700
Subject: [Intel-wired-lan] [PATCH net v1 2/2] iavf: Fix call trace
 during removing iavf driver
In-Reply-To: <20220527080919.2370640-2-jedrzej.jagielski@intel.com>
References: <20220527080919.2370640-1-jedrzej.jagielski@intel.com>
 <20220527080919.2370640-2-jedrzej.jagielski@intel.com>
Message-ID: <04b439d9-2e8f-7c50-3d52-bd6a6880edfd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 5/27/2022 1:09 AM, Jedrzej Jagielski wrote:
> From: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> 
> If VF has configured tc qdisc with number of queues less than original
> set and then the driver went in removing process, tc resources are also
> releasing. Attempt of modify real num tx/rx in this state is causing
> call trace, because kernel is trying to releasing uninitialized queues.
> 
> Fix by not modifying the number of queues when removing a driver.
> 
> Fixes: d5b33d024496 ("i40evf: add ndo_setup_tc callback to i40evf")
> Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>   drivers/net/ethernet/intel/iavf/iavf_main.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index eec74ee5fc19..1b46a97f4ad6 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -3478,6 +3478,9 @@ static int __iavf_setup_tc(struct net_device *netdev, void *type_data)
>   		}
>   	}
>   exit:
> +	if (iavf_is_remove_in_progress(adapter))
> +		return 0;

Why do we check this condition at the end of the function after 
everything is done instead of the beginning?

Also, this function from patch 1, is a refactor for checking a bit. 
Refactors shouldn't be going to net unless necessary. This patch can 
directly check the bit and the other patch can be sent as a follow on 
after this patch has been applied.

Thanks,
Tony

>   	return ret;
>   }
>   
