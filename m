From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 2 Apr 2020 03:41:10 +0000
Subject: [Intel-wired-lan] [PATCH 05/10] igc: Use netdev log helpers in
 igc_base.c
In-Reply-To: <20200325003824.5487-6-andre.guedes@intel.com>
References: <20200325003824.5487-1-andre.guedes@intel.com>
 <20200325003824.5487-6-andre.guedes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9722EC34@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Tuesday, March 24, 2020 5:38 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 05/10] igc: Use netdev log helpers in
> igc_base.c
> 
> This patch coverts one pr_debug() call to hw_dbg() in order to keep log
> output aligned with the rest of the driver. hw_dbg() is actually a macro
> defined in igc_hw.h that expands to netdev_dbg().
> 
> It also takes this opportunity to remove the '\n' character at the end
> of messages since it is automatically added to by netdev_dbg().
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_base.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
