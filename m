From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 11 Sep 2018 21:53:33 +0000
Subject: [Intel-wired-lan] [PATCH v7 10/11] igc: Add setup link
 functionality
In-Reply-To: <20180828160013.26757-1-sasha.neftin@intel.com>
References: <20180828160013.26757-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B965587FB@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sasha Neftin
> Sent: Tuesday, August 28, 2018 9:00 AM
> To: Neftin, Sasha <sasha.neftin@intel.com>; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v7 10/11] igc: Add setup link functionality
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
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |   1 +
>  drivers/net/ethernet/intel/igc/igc_base.c    |  41 ++++
>  drivers/net/ethernet/intel/igc/igc_defines.h |  38 +++
>  drivers/net/ethernet/intel/igc/igc_mac.c     | 271
> ++++++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_mac.h     |   2 +
>  drivers/net/ethernet/intel/igc/igc_main.c    |  30 +++
>  drivers/net/ethernet/intel/igc/igc_phy.c     | 334
> +++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_phy.h     |   2 +
>  8 files changed, 719 insertions(+)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
