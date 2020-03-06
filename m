From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 6 Mar 2020 20:46:18 +0000
Subject: [Intel-wired-lan] [PATCH v2 1/1] igc: Remove copper fiber
 switch control
In-Reply-To: <20200303182610.35628-1-sasha.neftin@intel.com>
References: <20200303182610.35628-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B97202ACF@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Tuesday, March 3, 2020 10:26 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 1/1] igc: Remove copper fiber switch
> control
> 
> i225 device support copper mode only
> PHY signal detect indication for copper fiber switch
> not applicable to i225 part
> 
> v1 -> v2:
> Address community comments and leave igc_ethtool.c no changes
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h | 2 --
>  drivers/net/ethernet/intel/igc/igc_main.c    | 9 ---------
>  2 files changed, 11 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
