From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 Apr 2016 21:13:08 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Return 64 bit stats values
In-Reply-To: <20160421184024.14525.87965.stgit@ixgbe-dev.jf.intel.com>
References: <20160421184024.14525.87965.stgit@ixgbe-dev.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2AF1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Preethi Banala
> Sent: Thursday, April 21, 2016 11:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Return 64 bit stats values
> 
> The code was ignoring higher 32 bits of stats registers. This patch correctly fills
> out 64 bit value in two 32 bit words.
> 
> Signed-off-by: Preethi Banala <preethi.banala@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Ethtool reg dump shows additional information
