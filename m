From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 2 Apr 2020 03:46:24 +0000
Subject: [Intel-wired-lan] [PATCH 08/10] igc: Remove '\n' from log
 strings in igc_mac.c
In-Reply-To: <20200325003824.5487-9-andre.guedes@intel.com>
References: <20200325003824.5487-1-andre.guedes@intel.com>
 <20200325003824.5487-9-andre.guedes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9722EC72@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Tuesday, March 24, 2020 5:38 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 08/10] igc: Remove '\n' from log strings in
> igc_mac.c
> 
> To keep log strings in igc_mac.c consistent with the rest of the driver
> code, this patch removes the '\n' character at the end. The newline
> character is automatically added by netdev_dbg() so there is no changes
> in the output.
> 
> Note: hw_dbg() is a macro that expands to netdev_dbg().
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_mac.c | 42 ++++++++++++------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
