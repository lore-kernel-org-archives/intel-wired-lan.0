From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 27 Feb 2019 03:30:50 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Extend the ethtool
 supporting
In-Reply-To: <20190214113137.17808-1-sasha.neftin@intel.com>
References: <20190214113137.17808-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9664771F@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sasha Neftin
> Sent: Thursday, February 14, 2019 3:32 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Extend the ethtool supporting
> 
> Add show and configure nfc methods to the ethtool.
> Show the specifies Rx ntuple filters.
> Configures receive network flow classification option or rules.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |  55 ++-
>  drivers/net/ethernet/intel/igc/igc_defines.h |   4 +
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 602
> +++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_main.c    | 145 +++++++
>  drivers/net/ethernet/intel/igc/igc_regs.h    |  11 +
>  5 files changed, 814 insertions(+), 3 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
