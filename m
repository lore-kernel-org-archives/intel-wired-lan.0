From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 23 Aug 2018 21:02:36 +0000
Subject: [Intel-wired-lan] [PATCH] igb: reduce CPU0 latency when
 updating statistics
In-Reply-To: <20180802171310.9295-1-jeffrey.t.kirsher@intel.com>
References: <20180802171310.9295-1-jeffrey.t.kirsher@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9655020A@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Thursday, August 2, 2018 10:13 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Jan Jablonsky <jan.jablonsky@thalesgroup.com>; Bernhard Kaindl
> <bernhard.kaindl@thalesgroup.com>
> Subject: [Intel-wired-lan] [PATCH] igb: reduce CPU0 latency when updating
> statistics
> 
> This change is based off of the work and suggestion of Jan Jablonsky
> <jan.jablonsky@thalesgroup.com>.
> 
> The Watchdog workqueue in igb driver is scheduled every 2s for each
> network interface. That includes updating a statistics protected by
> spinlock. Function igb_update_stats in this case will be protected
> against preemption. According to number of a statistics registers
> (cca 60), processing this function might cause additional cpu load
>  on CPU0.
> 
> In case of statistics spinlock may be replaced with mutex, which
> reduce latency on CPU0.
> 
> CC: Bernhard Kaindl  <bernhard.kaindl@thalesgroup.com>
> CC: Jan Jablonsky <jan.jablonsky@thalesgroup.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb.h         |  2 +-
>  drivers/net/ethernet/intel/igb/igb_ethtool.c |  4 ++--
>  drivers/net/ethernet/intel/igb/igb_main.c    | 14 +++++++-------
>  3 files changed, 10 insertions(+), 10 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
