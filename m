From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 13 Oct 2018 02:05:53 +0000
Subject: [Intel-wired-lan] [PATCH v8 10/11] igc: Add setup link
 functionality
In-Reply-To: <20181011071734.1996-1-sasha.neftin@intel.com>
References: <20181011071734.1996-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9657AD4E@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Sasha Neftin
> Sent: Thursday, October 11, 2018 12:18 AM
> To: Neftin, Sasha <sasha.neftin@intel.com>; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v8 10/11] igc: Add setup link functionality
> 
> Add link establishment methods
> Add auto negotiation methods
> Add read MAC address method
> 
> Sasha Neftin (v2):
> minor cosmetic changes
> 
> Sasha Neftin (v3):
> remove not addressed methods
> 
> Sasha Neftin (v4):
> address comments
> remove improperly insertion of method from a patch
> replace e1000_ prefix with igc_ prefix
> remove duplicate PHY MII defines
> 
> Sasha Neftin (v5):
> code clean
> remove obsolete flash_address reference
> fix initial autoneg advertisement and add 2.5G option
> add option to clear the 2.5 Gbps advertising bit and disable 2.5 Gbps speed
> 
> Sasha Neftin (v6):
> minor cosmetic changes
> 
> Sasha Neftin (v7):
> no changes
> 
> Sasha Neftin (v8):
> fix whitespaces in comments
> remove unneeded forward declarations
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |   1 +
>  drivers/net/ethernet/intel/igc/igc_base.c    |  40 ++++
>  drivers/net/ethernet/intel/igc/igc_defines.h |  38 +++
>  drivers/net/ethernet/intel/igc/igc_mac.c     | 271 ++++++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_mac.h     |   2 +
>  drivers/net/ethernet/intel/igc/igc_main.c    |  30 +++
>  drivers/net/ethernet/intel/igc/igc_phy.c     | 334
> +++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_phy.h     |   1 +
>  8 files changed, 717 insertions(+)
> 
 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
