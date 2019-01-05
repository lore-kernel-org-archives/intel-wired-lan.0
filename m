From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 5 Jan 2019 04:06:32 +0000
Subject: [Intel-wired-lan] [PATCH 1/1] igc: Remove unreachable code from
 igc_phy.c file
In-Reply-To: <20181211165541.42908-1-sasha.neftin@intel.com>
References: <20181211165541.42908-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9660FBFA@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sasha Neftin
> Sent: Tuesday, December 11, 2018 8:56 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/1] igc: Remove unreachable code from
> igc_phy.c file
> 
> Address community comment.
> Remove the unreachable code leads to the static checker warning.
> PHY functionality will be added later per demand.
> Reported by Dan Carpenter.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_phy.c | 8 --------
>  1 file changed, 8 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
