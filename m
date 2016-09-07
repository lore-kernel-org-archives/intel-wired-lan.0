From: Duyck, Alexander H <alexander.h.duyck@intel.com>
Date: Wed, 7 Sep 2016 14:49:39 +0000
Subject: [Intel-wired-lan] [PATCH 249/249]
 net:ethernet:intel:igb_main.c: Add Throttling disable option in order to
 decrease latency usually required by RT applications.
In-Reply-To: <48faffefd02040f7a2af65691454ad3c@Hummer.waves.com>
References: <20abe8058531466d8d60835ce88b6489@Hummer.waves.com>
 <48faffefd02040f7a2af65691454ad3c@Hummer.waves.com>
Message-ID: <1473259777.31962.401.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-09-06 at 14:46 +0000, Amir Yihie wrote:
> From e433f5bedd49a65b7337d025f3f204f0f21ad5e5 Mon Sep 17 00:00:00
> 2001
> From: amiry <amiry@waves.com>
> Date: Tue, 6 Sep 2016 14:58:38 +0300
> Subject: [PATCH 249/249] net:ethernet:intel:igb_main.c: Add
> Throttling disable
> ?option in order to decrease latency usually required by RT
> applications.
> 
> Add an option to Disable Throttling algorithm , which will result
> with minimum latency on received frames .
> mainly targets for RT application that look for low larceny and less
> cares about throughput .
> How to use :
> On insmod , add parameter : InterruptThrottleRate=0
> 
> This patch is currently against a linux 4.1.27-rt31 kernel.
> 
> Signed-off-by: Amir Yihie <amiry@waves.com>
> ---
> ?drivers/net/ethernet/intel/igb/igb_main.c | 11 +++++++++++
> ?1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
> b/drivers/net/ethernet/intel/igb/igb_main.c
> index 7dfbcde..9480850 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -251,6 +251,14 @@ static int debug = -1;
> ?module_param(debug, int, 0);
> ?MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
> ?
> +/* Interrupt Throttle Rate (interrupts/sec)
> + *
> + * Valid Range: 0=off, 3=dynamic conservative
> + */
> +static int InterruptThrottleRate = 3;
> +module_param(InterruptThrottleRate, int, 0);
> +MODULE_PARM_DESC(InterruptThrottleRate, "InterruptThrottleRate
> (0=off, 3=dynamic conservative)");
> +

This is creating redundant functionality. ?The same can be done via the
ethtool command "ethtool -C <iface> rx-usecs 0". ?Is there some reason
why you couldn't use ethtool?

> ?struct igb_reg_info {
> ????????u32 ofs;
> ????????char *name;
> @@ -2966,6 +2974,9 @@ static int igb_sw_init(struct igb_adapter
> *adapter)
> ????????adapter->rx_itr_setting = IGB_DEFAULT_ITR;
> ????????adapter->tx_itr_setting = IGB_DEFAULT_ITR;
> ?
> +???????if (InterruptThrottleRate == 0)
> +???????????????adapter->rx_itr_setting = InterruptThrottleRate;
> +
> ????????/* set default work limits */
> ????????adapter->tx_work_limit = IGB_DEFAULT_TX_WORK;

If you are going to use InterruptThrottleRate you might as well use it
fully instead of making it a boolean value with 0 having one meaning
and the default of 3 being another.

Thanks.

- Alex
