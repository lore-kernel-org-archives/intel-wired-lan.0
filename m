From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 13 Oct 2018 01:58:48 +0000
Subject: [Intel-wired-lan] [PATCH v8 02/11] igc: Add support for PF
In-Reply-To: <20181011071710.1623-1-sasha.neftin@intel.com>
References: <20181011071710.1623-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9657ACA1@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Sasha Neftin
> Sent: Thursday, October 11, 2018 12:17 AM
> To: Neftin, Sasha <sasha.neftin@intel.com>; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v8 02/11] igc: Add support for PF
> 
> This patch adds the basic defines and structures needed by the PF for
> operation. With this it is possible to bring up the interface,
> but without being able to configure any of the filters on
> the interface itself.
> Add skeleton for a function pointers.
> 
> Sasha Neftin (v2):
> add description
> fix code indentation
> 
> Sasha Neftin (v3):
> squash patches, clean code and remove unused values
> remove duplication
> 
> Sasha Neftin (v4):
> address comments
> remove unused PCIE definition
> remove unused MAX_MTA_REG definition
> remove unused NVM registers
> remove unused PCIE registers
> remove unused DMA registers
> remove unused Receive registers
> remove unused Transmit registers
> fix typos
> replace e1000_ prefix with igc_ prefix
> remove unused PCIE defines
> remove unused EEE register, will be add per needs
> remove unused SERDES definitions
> 
> Sasha Neftin (v5):
> resolve automatic test system error
> add __iomem to *hw_addr definition
> remove obsolete flash_address definition
> 
> Sasha Neftin (v6):
> fix code indentation
> remove unused defines from igc_defines.h
> minor cosmetic changes
> 
> Sasha Neftin (v7):
> no changes
> 
> Sasha Neftin (v8):
> fix whitespaces in comments
> remove unneeded forward declaration of igc_hw
> remove duplication
> remove obsolete pci code
> clean code
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/Makefile      |   2 +-
>  drivers/net/ethernet/intel/igc/igc.h         |  13 ++
>  drivers/net/ethernet/intel/igc/igc_defines.h |  30 +++++
>  drivers/net/ethernet/intel/igc/igc_hw.h      |  82 ++++++++++++
>  drivers/net/ethernet/intel/igc/igc_i225.h    |  10 ++
>  drivers/net/ethernet/intel/igc/igc_mac.c     |   5 +
>  drivers/net/ethernet/intel/igc/igc_mac.h     |  11 ++
>  drivers/net/ethernet/intel/igc/igc_main.c    |  98 ++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_regs.h    | 192
> +++++++++++++++++++++++++++
>  9 files changed, 442 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/intel/igc/igc_defines.h
>  create mode 100644 drivers/net/ethernet/intel/igc/igc_i225.h
>  create mode 100644 drivers/net/ethernet/intel/igc/igc_mac.c
>  create mode 100644 drivers/net/ethernet/intel/igc/igc_mac.h
>  create mode 100644 drivers/net/ethernet/intel/igc/igc_regs.h
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
