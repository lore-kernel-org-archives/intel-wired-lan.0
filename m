From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 8 Oct 2019 23:18:05 +0000
Subject: [Intel-wired-lan] [PATCH v1] igc: Clean up unused shadow_vfta
 pointer
In-Reply-To: <20191003114701.33966-1-sasha.neftin@intel.com>
References: <20191003114701.33966-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9714938E@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of
> Sasha Neftin
> Sent: Thursday, October 3, 2019 4:47 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1] igc: Clean up unused shadow_vfta pointer
> 
> VLAN filter table array not implemented yet and shadow_vfta pointer
> not used. Clean up the code and remove the unused shadow_vfta pointer.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h      | 1 -
>  drivers/net/ethernet/intel/igc/igc_main.c | 1 -
>  2 files changed, 2 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
