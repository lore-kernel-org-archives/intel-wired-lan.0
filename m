From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 2 Mar 2016 21:21:33 +0000
Subject: [Intel-wired-lan] [PATCH RESEND v2] ixgbe: on recv
	increment	rx.ring->stats.yields
In-Reply-To: <1453277324-6180-1-git-send-email-ptikhomirov@virtuozzo.com>
References: <1453277324-6180-1-git-send-email-ptikhomirov@virtuozzo.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99C360@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Pavel Tikhomirov
> Sent: Wednesday, January 20, 2016 12:09 AM
> To: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; Kirsher,
> Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: devel at openvz.org; Andrew Vagin <avagin@parallels.com>; Konstantin
> Khorenko <khorenko@virtuozzo.com>
> Subject: [Intel-wired-lan] [PATCH RESEND v2] ixgbe: on recv increment
> rx.ring->stats.yields
> 
> It seem to be non intentionaly changed to tx in commit adc810900a70
> ("ixgbe: Refactor busy poll socket code to address multiple issues")
> 
> Lock is taken from ixgbe_low_latency_recv, and there under this lock we use
> ixgbe_clean_rx_irq so it looks wrong for me to increment tx counter.
> 
> Yield stats can be shown through ethtool:
> ethtool -S enp129s0 | grep yield
> 
> v2: follow commit citing style
> 
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code change present, yield counters increment as expected with busy polling enabled.
