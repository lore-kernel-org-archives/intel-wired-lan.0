From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 2 Apr 2020 03:51:42 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unneeded definition
In-Reply-To: <20200329090151.42247-1-sasha.neftin@intel.com>
References: <20200329090151.42247-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9722ECAE@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Sasha
> Neftin
> Sent: Sunday, March 29, 2020 2:02 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unneeded definition
> 
> PHY_FORCE_LIMIT definition not in use and could be removed
> i225 parts support auto negitiation mechanism
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h | 1 -
>  1 file changed, 1 deletion(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
