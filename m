From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 15 Apr 2017 07:58:14 +0000
Subject: [Intel-wired-lan] [PATCH 3/3] e1000e: Add Support for
	38.4MHZ	frequency
In-Reply-To: <20170406072703.10810-1-sasha.neftin@intel.com>
References: <20170406072703.10810-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C5E9D72@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Sasha Neftin
> Sent: Thursday, April 6, 2017 12:27 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [PATCH 3/3] e1000e: Add Support for 38.4MHZ
> frequency
> 
> Description: add support for 38.4MHz frequency is required for PTP
> on CannonLake. SYSTIM frequency adjustment attributes for TIMINCA are
> get/set dependent on the hardware clock frequency for a different
> types of adapters. 38.4MHz frequency supported by CannonLake
> and active once time synchronisation mechanism was enabled
> Changed abbreviation from Hz to HZ to be compliant checkpatch code style
> 
> Reviewed-by: Raanan Avargil <raanan.avargil@intel.com>
> Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/e1000.h  | 28 ++++++++++--------
>  drivers/net/ethernet/intel/e1000e/netdev.c | 47 +++++++++++++++++++++---
> ------
>  2 files changed, 50 insertions(+), 25 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
