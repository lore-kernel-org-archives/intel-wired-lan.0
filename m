From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 6 Jan 2018 05:14:31 +0000
Subject: [Intel-wired-lan] [PATCH 09/27] igb: Use timecounter_initialize
 interface
In-Reply-To: <1513323522-15021-10-git-send-email-sagar.a.kamble@intel.com>
References: <1513323522-15021-1-git-send-email-sagar.a.kamble@intel.com>
 <1513323522-15021-10-git-send-email-sagar.a.kamble@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C731EFD@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sagar Arun Kamble
> Sent: Thursday, December 14, 2017 11:38 PM
> To: linux-kernel at vger.kernel.org
> Cc: intel-wired-lan at lists.osuosl.org; Richard Cochran
> <richardcochran@gmail.com>; Kamble, Sagar A
> <sagar.a.kamble@intel.com>; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH 09/27] igb: Use timecounter_initialize
> interface
> 
> With new interface timecounter_initialize we can initialize timecounter
> fields and underlying cyclecounter together. Update igb ptp timecounter
> init with this new function.
> 
> Signed-off-by: Sagar Arun Kamble <sagar.a.kamble@intel.com>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/net/ethernet/intel/igb/igb.h     |  4 ++++
>  drivers/net/ethernet/intel/igb/igb_ptp.c | 23 ++++++++++++++---------
>  2 files changed, 18 insertions(+), 9 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
