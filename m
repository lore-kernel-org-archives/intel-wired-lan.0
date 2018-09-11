From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 11 Sep 2018 21:49:49 +0000
Subject: [Intel-wired-lan] [PATCH v7 05/11] igc: Add support for Tx/Rx
 rings
In-Reply-To: <20180828155958.26473-1-sasha.neftin@intel.com>
References: <20180828155958.26473-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B965587A2@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sasha Neftin
> Sent: Tuesday, August 28, 2018 9:00 AM
> To: Neftin, Sasha <sasha.neftin@intel.com>; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v7 05/11] igc: Add support for Tx/Rx rings
> 
> This change adds the defines and structures necessary to support both Tx
> and Rx descriptor rings.
> 
> Sasha Neftin (v2):
> fixed code indentation
> 
> Sasha Neftin (v3):
> minor code fixes
> 
> Sasha Neftin (v4):
> refactor of igc_clean_tx_ring method and resovle rmmod hang problem
> remove unused code
> address comments
> fix code indentation
> fix xmas layout
> fix header of igc_tx_buffer method
> remove duplicate defines of IGC_TX_HTHRESH and IGC_TX_PTHRESH
> fix typo
> replace e1000_ prefix with igc_prefix
> 
> Sasha Neftin (v5):
> remove unused defines
> 
> Sasha Neftin (v6):
> minor cosmetic changes
> 
> Sasha Neftin (v7):
> no changes
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/Makefile      |   2 +-
>  drivers/net/ethernet/intel/igc/igc.h         | 126 ++++
>  drivers/net/ethernet/intel/igc/igc_base.c    |  83 +++
>  drivers/net/ethernet/intel/igc/igc_base.h    |  89 +++
>  drivers/net/ethernet/intel/igc/igc_defines.h |  43 ++
>  drivers/net/ethernet/intel/igc/igc_hw.h      |   1 +
>  drivers/net/ethernet/intel/igc/igc_main.c    | 836
> +++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_regs.h    |   3 +
>  8 files changed, 1182 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/intel/igc/igc_base.c
>  create mode 100644 drivers/net/ethernet/intel/igc/igc_base.h
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
