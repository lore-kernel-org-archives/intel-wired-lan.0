From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 13 Oct 2018 01:59:33 +0000
Subject: [Intel-wired-lan] [PATCH v8 03/11] igc: Add netdev
In-Reply-To: <20181011071713.1667-1-sasha.neftin@intel.com>
References: <20181011071713.1667-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9657ACBB@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Sasha Neftin
> Sent: Thursday, October 11, 2018 12:17 AM
> To: Neftin, Sasha <sasha.neftin@intel.com>; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v8 03/11] igc: Add netdev
> 
> Now that we have the ability to configure the basic settings on the device
> we can start allocating and configuring a netdev for the interface.
> 
> Sasha Neftin (v2):
> add description
> 
> Sasha Neftin (v3):
> minor cosmetic changes
> 
> Sasha Neftin (v4):
> address comments
> fix code indentation
> replace e1000_ prefix with igc_ prefix
> optimize pcie access
> 
> Sasha Neftin (v5):
> change return value of igc_up() method to void
> 
> Sasha Neftin (v6):
> fix define of MAX_Q_VECTORS
> fix code indentation
> minor cosmetic changes
> 
> Sasha Neftin (v7):
> fix setting netdev->name
> move MODULE macro defines to begin of the file
> 
> Sasha Neftin (v8):
> fix whitespaces in comments
> fix igc_update_stats method location
> replace spaces with tab
> remove unneeded blank line
> fix few comments and add correct explanation of code
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |  48 +++
>  drivers/net/ethernet/intel/igc/igc_defines.h |  15 +
>  drivers/net/ethernet/intel/igc/igc_hw.h      |   1 +
>  drivers/net/ethernet/intel/igc/igc_main.c    | 471
> ++++++++++++++++++++++++++-
>  4 files changed, 534 insertions(+), 1 deletion(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
