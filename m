From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 5 Mar 2020 01:35:08 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused MDIC_DEST
 mask
In-Reply-To: <20200227165723.21378-1-sasha.neftin@intel.com>
References: <20200227165723.21378-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B97201473@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Thursday, February 27, 2020 8:57 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused MDIC_DEST
> mask
> 
> Formally Destination bit should be kept reserved to
> support legacy drivers and ignore on write/read
> operation
> Not applicable for i225 parts
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h | 1 -
>  1 file changed, 1 deletion(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
