From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 11 Sep 2018 21:48:40 +0000
Subject: [Intel-wired-lan] [PATCH v7 03/11] igc: Add netdev
In-Reply-To: <20180828155952.26368-1-sasha.neftin@intel.com>
References: <20180828155952.26368-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B96558782@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sasha Neftin
> Sent: Tuesday, August 28, 2018 9:00 AM
> To: Neftin, Sasha <sasha.neftin@intel.com>; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v7 03/11] igc: Add netdev
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
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |  48 +++
>  drivers/net/ethernet/intel/igc/igc_defines.h |  15 +
>  drivers/net/ethernet/intel/igc/igc_hw.h      |   1 +
>  drivers/net/ethernet/intel/igc/igc_main.c    | 483
> ++++++++++++++++++++++++++-
>  4 files changed, 540 insertions(+), 7 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
