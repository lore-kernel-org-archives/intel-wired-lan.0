From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Thu, 8 Jul 2021 14:39:17 +0300
Subject: [Intel-wired-lan] [PATCH next-queue v2 5/5] igc: Export LEDs
In-Reply-To: <20210629044332.3491232-6-vinicius.gomes@intel.com>
References: <20210629044332.3491232-1-vinicius.gomes@intel.com>
 <20210629044332.3491232-6-vinicius.gomes@intel.com>
Message-ID: <9375494f-ae6c-4dcd-65cf-bfa8b42e6660@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/29/2021 07:43, Vinicius Costa Gomes wrote:
> From: Kurt Kanzenbach <kurt@linutronix.de>
> 
> Each i225 has three LEDs. Export them via the LED class framework.
> 
> Each LED is controllable via sysfs. Example:
> 
> $ cd /sys/class/leds/igc_led0
> $ cat brightness      # Current Mode
> $ cat max_brightness  # 15
> $ echo 0 > brightness # Mode 0
> $ echo 1 > brightness # Mode 1
> 
> The brightness field here reflects the different LED modes ranging
> from 0 to 15.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   drivers/net/ethernet/intel/Kconfig           |   1 +
>   drivers/net/ethernet/intel/igc/igc.h         |  10 ++
>   drivers/net/ethernet/intel/igc/igc_defines.h |  10 ++
>   drivers/net/ethernet/intel/igc/igc_main.c    | 132 +++++++++++++++++++
>   drivers/net/ethernet/intel/igc/igc_regs.h    |   2 +
>   5 files changed, 155 insertions(+)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
