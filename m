From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Mon, 21 Jun 2021 15:33:53 +0300
Subject: [Intel-wired-lan] [PATCH next-queue v1 5/5] igc: Export LEDs
In-Reply-To: <20210611003924.492853-6-vinicius.gomes@intel.com>
References: <20210611003924.492853-1-vinicius.gomes@intel.com>
 <20210611003924.492853-6-vinicius.gomes@intel.com>
Message-ID: <d99a5b9d-8df2-2eb2-36f2-c2710b43191a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/11/2021 03:39, Vinicius Costa Gomes wrote:
> From: Kurt Kanzenbach <kurt@linutronix.de>
> 
> Each i225 has three LEDs. Export them via the LED class framework.
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
