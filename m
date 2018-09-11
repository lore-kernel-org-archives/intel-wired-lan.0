From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 11 Sep 2018 21:52:57 +0000
Subject: [Intel-wired-lan] [PATCH v7 09/11] igc: Add code for PHY support
In-Reply-To: <20180828160010.26700-1-sasha.neftin@intel.com>
References: <20180828160010.26700-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B965587DF@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sasha Neftin
> Sent: Tuesday, August 28, 2018 9:00 AM
> To: Neftin, Sasha <sasha.neftin@intel.com>; intel-wired-lan at lists.osuosl.org
> Cc: Duyck, Alexander H <alexander.h.duyck@intel.com>
> Subject: [Intel-wired-lan] [PATCH v7 09/11] igc: Add code for PHY support
> 
> Sasha Neftin (v2):
> minor cosmetic changes
> 
> Alexander Duyck (v3.5):
> Made non-gpy versions of phy functions static
> Move xmdio functions to avoid need for prototype function
> Move reset, read_reg, and write_reg ops into e1000_phy_ops_base
> Drop code implying more than one function
> Fix merge conflict with v3.5 of NVM code.
> 
> Sasha Neftin (v3):
> Introduce temporary workaround for PHY power down.
> 
> Sasha Neftin (v4):
> address comments
> remove space
> fix minor grammar typo
> replace e1000_ prefix with igc_ prefix
> 
> Sasha Neftin (v5):
> update IGC_GEN_POLL_TIMEOUT value to 1920
> fix code indentation
> 
> Sasha Neftin (v6):
> remove double defines from igc_defines.h
> remove unused defines from igc_defines.h
> remove unused code from igc_phy.c
> fix enum igc_bus_type definition
> minor cosmetic changes
> 
> Sasha Neftin (v7):
> no changes
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/Makefile      |   2 +-
>  drivers/net/ethernet/intel/igc/igc.h         |  16 +
>  drivers/net/ethernet/intel/igc/igc_base.c    | 125 ++++++++
>  drivers/net/ethernet/intel/igc/igc_base.h    |   1 +
>  drivers/net/ethernet/intel/igc/igc_defines.h |  79 +++++
>  drivers/net/ethernet/intel/igc/igc_hw.h      |  54 ++++
>  drivers/net/ethernet/intel/igc/igc_mac.c     |  45 +++
>  drivers/net/ethernet/intel/igc/igc_mac.h     |  11 +
>  drivers/net/ethernet/intel/igc/igc_main.c    |  11 +
>  drivers/net/ethernet/intel/igc/igc_phy.c     | 456
> +++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_phy.h     |  20 ++
>  drivers/net/ethernet/intel/igc/igc_regs.h    |   3 +
>  12 files changed, 822 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/intel/igc/igc_phy.c
>  create mode 100644 drivers/net/ethernet/intel/igc/igc_phy.h
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
