From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 15 Apr 2017 07:57:40 +0000
Subject: [Intel-wired-lan] [PATCH 2/3] e1000e: Add Support for CannonLake
In-Reply-To: <20170406072647.10753-1-sasha.neftin@intel.com>
References: <20170406072647.10753-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C5E9D61@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH 2/3] e1000e: Add Support for CannonLake
> 
> Description: propagation of CannonLake mac type to
> driver functionality
> 
> Reviewed-by: Raanan Avargil <raanan.avargil@intel.com>
> Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ethtool.c | 10 ++--
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 82 +++++++++++++++------------
> --
>  drivers/net/ethernet/intel/e1000e/netdev.c  | 29 +++++-----
>  drivers/net/ethernet/intel/e1000e/ptp.c     |  4 +-
>  4 files changed, 63 insertions(+), 62 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
