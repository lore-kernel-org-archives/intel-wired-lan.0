From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 Apr 2016 21:26:59 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Revise populating few
 registers	and macro definitions
In-Reply-To: <20160421184035.14573.50191.stgit@ixgbe-dev.jf.intel.com>
References: <20160421184035.14573.50191.stgit@ixgbe-dev.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2B04@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Preethi Banala
> Sent: Thursday, April 21, 2016 11:41 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Revise populating few registers and
> macro definitions
> 
> Revise populating few registers in ixgbe_get_regs() and macro definitions.
> Before applying patch:
> $ du -k objs/drivers/net/ethernet/intel/ixgbe/ixgbe.ko
> 8572    objs/drivers/net/ethernet/intel/ixgbe/ixgbe.ko
> After applying patch:
> $ du -k objs/drivers/net/ethernet/intel/ixgbe/ixgbe.ko
> 8568    objs/drivers/net/ethernet/intel/ixgbe/ixgbe.ko
> 
> Signed-off-by: Preethi Banala <preethi.banala@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   18 ++++++------------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h    |   10 ++--------
>  2 files changed, 8 insertions(+), 20 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
