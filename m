From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 11 Oct 2017 01:07:48 +0000
Subject: [Intel-wired-lan] [PATCH net] driver: e1000: fix race condition
 between e1000_down() and e1000_watchdog
In-Reply-To: <20170916160000.3560-1-v.maffione@gmail.com>
References: <20170916160000.3560-1-v.maffione@gmail.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C6BE222@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-
> owner at vger.kernel.org] On Behalf Of Vincenzo Maffione
> Sent: Saturday, September 16, 2017 9:00 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; Vincenzo Maffione <v.maffione@gmail.com>
> Subject: [PATCH net] driver: e1000: fix race condition between e1000_down()
> and e1000_watchdog
> 
> This patch fixes a race condition that can result into the interface being
> up and carrier on, but with transmits disabled in the hardware.
> The bug may show up by repeatedly IFF_DOWN+IFF_UP the interface, which
> allows e1000_watchdog() interleave with e1000_down().
> 
>     CPU x                           CPU y
>     --------------------------------------------------------------------
>     e1000_down():
>         netif_carrier_off()
>                                     e1000_watchdog():
>                                         if (carrier == off) {
>                                             netif_carrier_on();
>                                             enable_hw_transmit();
>                                         }
>         disable_hw_transmit();
>                                     e1000_watchdog():
>                                         /* carrier on, do nothing */
> 
> Signed-off-by: Vincenzo Maffione <v.maffione@gmail.com>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
