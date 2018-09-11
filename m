From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 11 Sep 2018 21:52:27 +0000
Subject: [Intel-wired-lan] [PATCH v7 08/11] igc: Add NVM support
In-Reply-To: <20180828160007.26651-1-sasha.neftin@intel.com>
References: <20180828160007.26651-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B965587CB@ORSMSX101.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v7 08/11] igc: Add NVM support
> 
> Add code for NVM support and get MAC address, complete probe
> method.
> 
> Sasha Neftin (v2):
> minor cosmetic changes
> 
> Alexander Duyck (v3):
> NVM access code optimization
> 
> Sasha Neftin (v4):
> fix xmas tree layout
> remove no need spaces
> rework igc_read_nvm_srrd/srwr and igc_validate_nvm_checksum_i225
> fix few methods as suggested by Shannon Nelson's approach
> remove obsolete comments
> replace e1000_ prefix with igc_ prefix
> remove unused NVM control definitions
> remove unused NVM Word offsets
> remove unused SW FW SYNC definition
> fix duplication of mask definition
> 
> Sasha Neftin (v5):
> no changes
> 
> Sasha Neftin (v6):
> minor cosmetic changes
> remove duplication of defines
> 
> Sasha Neftin (v7):
> fix kbuild test robot warning
> remove unneeded ret_val from igc_init_nvm_params_i225 method
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/Makefile      |   2 +-
>  drivers/net/ethernet/intel/igc/igc.h         |   6 +
>  drivers/net/ethernet/intel/igc/igc_base.c    | 111 +++++++++
>  drivers/net/ethernet/intel/igc/igc_defines.h |  52 ++++
>  drivers/net/ethernet/intel/igc/igc_hw.h      |   3 +
>  drivers/net/ethernet/intel/igc/igc_i225.c    | 349
> +++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_i225.h    |   3 +
>  drivers/net/ethernet/intel/igc/igc_mac.c     | 170 +++++++++++++
>  drivers/net/ethernet/intel/igc/igc_mac.h     |   5 +
>  drivers/net/ethernet/intel/igc/igc_main.c    |  20 +-
>  drivers/net/ethernet/intel/igc/igc_nvm.c     | 215 +++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_nvm.h     |  14 ++
>  drivers/net/ethernet/intel/igc/igc_regs.h    |   3 +
>  13 files changed, 950 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/net/ethernet/intel/igc/igc_nvm.c
>  create mode 100644 drivers/net/ethernet/intel/igc/igc_nvm.h
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
