From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 21 Apr 2016 21:56:29 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: check EEPROM for WOL
 support	for X540 and above
In-Reply-To: <20160421183712.21311.37417.stgit@localhost6.localdomain6>
References: <20160421183706.21311.93388.stgit@localhost6.localdomain6>
 <20160421183712.21311.37417.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2907@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Thursday, April 21, 2016 11:37 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/2] ixgbe: check EEPROM for WOL support
> for X540 and above
> 
> This change aims to simplify the logic we use to determine WOL support by
> reading the EEPROM bits for MACs X540 and newer.
> 
> Also some cleanups in ixgbe_wol_supported() - changed return type to bool
> and removed redundant return variable by simply using return after the
> checks.
> 
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |    4 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   49 ++++++++++++---------
> ----
>  2 files changed, 25 insertions(+), 28 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Ethtool correctly reports WOL support
