From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 5 Mar 2020 01:13:31 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused
 CTRL_EXT_LINK_MODE_MASK
In-Reply-To: <20200227171912.11007-1-sasha.neftin@intel.com>
References: <20200227171912.11007-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B97201456@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Thursday, February 27, 2020 9:19 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove unused
> CTRL_EXT_LINK_MODE_MASK
> 
> We support only copper mode
> Not applicable for i225 parts
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h | 3 ---
>  1 file changed, 3 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
