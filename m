From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Fri, 27 May 2022 14:20:57 +0200
Subject: [Intel-wired-lan] [PATCH net v1 2/2] iavf: Fix call trace
 during removing iavf driver
In-Reply-To: <20220527080919.2370640-2-jedrzej.jagielski@intel.com>
References: <20220527080919.2370640-1-jedrzej.jagielski@intel.com>
 <20220527080919.2370640-2-jedrzej.jagielski@intel.com>
Message-ID: <9ff865cc-92f0-b719-b2c1-bb6e0ec53a27@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Jedrzej, dear Grzegorz,


Am 27.05.22 um 10:09 schrieb Jedrzej Jagielski:
> From: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>

For the summary, maybe be more specific about the action:

 > Do not modify queue number when removing iavf driver

> If VF has configured tc qdisc with number of queues less than original
> set and then the driver went in removing process, tc resources are also

s/went/goes/

> releasing. Attempt of modify real num tx/rx in this state is causing

released?

> call trace, because kernel is trying to releasing uninitialized queues.

to release

Please add parts of the call trace.

> 
> Fix by not modifying the number of queues when removing a driver.

Fix *it* by ?


Kind regards,

Paul

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
> +
>   	return ret;
>   }
>   
