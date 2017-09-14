From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 14 Sep 2017 23:48:29 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: apply burst mode settings
	only on default
In-Reply-To: <20170825150626.2843-1-willemdebruijn.kernel@gmail.com>
References: <20170825150626.2843-1-willemdebruijn.kernel@gmail.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C6A055D@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-
> owner at vger.kernel.org] On Behalf Of Willem de Bruijn
> Sent: Friday, August 25, 2017 8:06 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; Brandeburg,
> Jesse <jesse.brandeburg@intel.com>; Willem de Bruijn
> <willemb@google.com>
> Subject: [PATCH] e1000e: apply burst mode settings only on default
> 
> From: Willem de Bruijn <willemb@google.com>
> 
> Devices that support FLAG2_DMA_BURST have different default values
> for RDTR and RADV. Apply burst mode default settings only when no
> explicit value was passed at module load.
> 
> The RDTR default is zero. If the module is loaded for low latency
> operation with RxIntDelay=0, do not override this value with a burst
> default of 32.
> 
> Move the decision to apply burst values earlier, where explicitly
> initialized module variables can be distinguished from defaults.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> ---
>  drivers/net/ethernet/intel/e1000e/e1000.h  |  4 ----
>  drivers/net/ethernet/intel/e1000e/netdev.c |  8 --------
>  drivers/net/ethernet/intel/e1000e/param.c  | 16 +++++++++++++++-
>  3 files changed, 15 insertions(+), 13 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
