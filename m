From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 13 Oct 2018 02:00:19 +0000
Subject: [Intel-wired-lan] [PATCH v8 04/11] igc: Add interrupt support
In-Reply-To: <20181011071716.1711-1-sasha.neftin@intel.com>
References: <20181011071716.1711-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9657ACD0@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Sasha Neftin
> Sent: Thursday, October 11, 2018 12:17 AM
> To: Neftin, Sasha <sasha.neftin@intel.com>; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v8 04/11] igc: Add interrupt support
> 
> This patch set adds interrupt support for the igc interfaces.
> 
> Sasha Neftin (v2):
> fixed comments
> 
> Sasha Neftin (v3):
> minor cosmetic changes
> 
> Sasha Neftin (v4):
> address comments
> move IGC_NO_QUEUE to .h file
> add header to irqreturn_t igc_msix_other method
> fix comment in igc_write_ivar method
> fix xmas tree layout
> fix code indentation
> replace e1000_ prefix with igc_ prefix
> introduce BIT() macro
> 
> Sasha Neftin (v5):
> fix xmas tree tree layout
> fix code indentation
> 
> Sasha Neftin (v6):
> minor cosmetic changes
> 
> Sasha Neftin (v7):
> no changes
> 
> Sasha Neftin (v8):
> fix whitespaces in comments
> replace spaces with tab
> remove unused CONFIG_IGC_DISABLE_PACKET_SPLIT define
> remove unneeded forward declarations
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |  127 ++++
>  drivers/net/ethernet/intel/igc/igc_defines.h |   40 +
>  drivers/net/ethernet/intel/igc/igc_hw.h      |   84 +++
>  drivers/net/ethernet/intel/igc/igc_main.c    | 1016
> ++++++++++++++++++++++++++
>  4 files changed, 1267 insertions(+)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
