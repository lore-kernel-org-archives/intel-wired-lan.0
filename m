From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 1 Feb 2019 23:15:34 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add ethtool support
In-Reply-To: <20190130171314.2829-1-sasha.neftin@intel.com>
References: <20190130171314.2829-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B96621201@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sasha Neftin
> Sent: Wednesday, January 30, 2019 9:13 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add ethtool support
> 
> This patch adds basic ethtool support to the device to allow
> for configuration.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/Makefile      |    3 +-
>  drivers/net/ethernet/intel/igc/igc.h         |   34 +-
>  drivers/net/ethernet/intel/igc/igc_base.c    |    1 +
>  drivers/net/ethernet/intel/igc/igc_defines.h |    4 +
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 1032
> ++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_hw.h      |    1 +
>  drivers/net/ethernet/intel/igc/igc_main.c    |  109 ++-
>  drivers/net/ethernet/intel/igc/igc_regs.h    |    3 +
>  8 files changed, 1169 insertions(+), 18 deletions(-)
>  create mode 100644 drivers/net/ethernet/intel/igc/igc_ethtool.c
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
