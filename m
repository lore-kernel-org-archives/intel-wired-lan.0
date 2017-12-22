From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 Dec 2017 20:37:34 +0000
Subject: [Intel-wired-lan] [PATCH 10/27] ixgbe: Use
 timecounter_initialize interface
In-Reply-To: <1513323522-15021-11-git-send-email-sagar.a.kamble@intel.com>
References: <1513323522-15021-1-git-send-email-sagar.a.kamble@intel.com>
 <1513323522-15021-11-git-send-email-sagar.a.kamble@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8CBC10@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sagar Arun Kamble
> Sent: Thursday, December 14, 2017 11:38 PM
> To: linux-kernel at vger.kernel.org
> Cc: intel-wired-lan at lists.osuosl.org; Richard Cochran
> <richardcochran@gmail.com>; Kamble, Sagar A
> <sagar.a.kamble@intel.com>; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH 10/27] ixgbe: Use timecounter_initialize
> interface
> 
> With new interface timecounter_initialize we can initialize timecounter fields
> and underlying cyclecounter together. Update ixgbe ptp timecounter init
> with this new function.
> 
> Signed-off-by: Sagar Arun Kamble <sagar.a.kamble@intel.com>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  6 +++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  4 +--
> drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c  | 45 +++++++++++++++-------
> -----
>  3 files changed, 32 insertions(+), 23 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


