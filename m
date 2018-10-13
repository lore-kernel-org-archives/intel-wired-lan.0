From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 13 Oct 2018 02:07:00 +0000
Subject: [Intel-wired-lan] [PATCH v8 11/11] igc: Add watchdog
In-Reply-To: <20181011071736.2041-1-sasha.neftin@intel.com>
References: <20181011071736.2041-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9657AD62@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Sasha Neftin
> Sent: Thursday, October 11, 2018 12:18 AM
> To: Neftin, Sasha <sasha.neftin@intel.com>; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v8 11/11] igc: Add watchdog
> 
> Code completion, remove obsolete code
> Add watchdog methods
> 
> Sasha Neftin (v2):
> minor cosmetic changes
> 
> Sasha Neftin (v3):
> resolve conflict and code optimization
> 
> Sasha Neftin (v4):
> fix update phy info for a watchdog task
> remove no need media_change type and media_swap method
> code optimization
> address comments
> replace e1000_ prefix with igc_ prefix
> 
> Sasha Neftin (v5):
> remove unused defines
> 
> Sasha Neftin (v6):
> no changes
> 
> Sasha Neftin (v7):
> no changes
> 
> Sasha Neftin (v8):
> fix whitespaces in comments
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |  12 ++
>  drivers/net/ethernet/intel/igc/igc_defines.h |  11 ++
>  drivers/net/ethernet/intel/igc/igc_hw.h      |   1 +
>  drivers/net/ethernet/intel/igc/igc_main.c    | 232
> +++++++++++++++++++++++++++
>  4 files changed, 256 insertions(+)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
