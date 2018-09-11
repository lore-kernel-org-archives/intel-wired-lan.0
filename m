From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 11 Sep 2018 21:51:29 +0000
Subject: [Intel-wired-lan] [PATCH v7 07/11] igc: Add HW initialization
 code
In-Reply-To: <20180828160004.26596-1-sasha.neftin@intel.com>
References: <20180828160004.26596-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B965587BE@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sasha Neftin
> Sent: Tuesday, August 28, 2018 9:00 AM
> To: Neftin, Sasha <sasha.neftin@intel.com>; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v7 07/11] igc: Add HW initialization code
> 
> Add code for hw initialization and reset.
> Add code for semaphore handling.
> 
> Sasha Neftin (v2):
> fix code indentation
> refactor of igc_desc_unused method
> 
> Sasha Neftin (v3):
> clean code and remove unused methods
> 
> Sasha Neftin (v4):
> address comments
> fix comments in e1000_i225.c and e1000_regs.h files
> fix xmas tree layout
> fix typos in e1000_mac.c file
> replace e1000_ prefix with igc_ prefix
> 
> Sasha Neftin (v5):
> fix code indentation
> 
> Sasha Neftin (v6):
> fix code indentation
> remove unused defines
> minor cosmetic changes
> 
> Sasha Neftin (v7):
> fix kbuild test robot warning
> remove unneeded ret_val from igc_set_fc_watermarks method
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/Makefile      |   2 +-
>  drivers/net/ethernet/intel/igc/igc_base.c    | 192 ++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_base.h    |   2 +
>  drivers/net/ethernet/intel/igc/igc_defines.h |  36 +++
>  drivers/net/ethernet/intel/igc/igc_hw.h      |  85 +++++++
>  drivers/net/ethernet/intel/igc/igc_i225.c    | 141 ++++++++++++
>  drivers/net/ethernet/intel/igc/igc_mac.c     | 319
> +++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_mac.h     |  11 +
>  drivers/net/ethernet/intel/igc/igc_main.c    |  21 ++
>  drivers/net/ethernet/intel/igc/igc_regs.h    |  20 ++
>  10 files changed, 828 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/intel/igc/igc_i225.c
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
