From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 5 Jan 2019 04:06:47 +0000
Subject: [Intel-wired-lan] [PATCH 1/1] igc: Fix code redundancy
In-Reply-To: <20181218092954.29914-1-sasha.neftin@intel.com>
References: <20181218092954.29914-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9660FC07@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sasha Neftin
> Sent: Tuesday, December 18, 2018 1:30 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/1] igc: Fix code redundancy
> 
> Remove redundant igc_check_for_link_base code and replace it with
> an igc_check_for_copper_link method.
> Fix duplication of IGC_ADVTXD_PAYLEN_SHIFT mask declaration.
> Remove obsolete IGC_SCVPC register definition.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_base.c | 20 ++------------------
>  drivers/net/ethernet/intel/igc/igc_base.h |  3 ---
>  drivers/net/ethernet/intel/igc/igc_regs.h |  1 -
>  3 files changed, 2 insertions(+), 22 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
