From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 19 Mar 2020 07:01:21 +0000
Subject: [Intel-wired-lan] [PATCH] igc: Remove dead code related to
 flower filter
In-Reply-To: <20200307003642.25590-1-andre.guedes@intel.com>
References: <20200307003642.25590-1-andre.guedes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B97223809@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Friday, March 6, 2020 4:37 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] igc: Remove dead code related to flower filter
> 
> IGC driver has no support for tc-flower filters so this patch removes
> some leftover code, probably copied from IGB driver by mistake.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h      | 1 -
>  drivers/net/ethernet/intel/igc/igc_main.c | 3 ---
>  2 files changed, 4 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
