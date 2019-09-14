From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 14 Sep 2019 01:07:53 +0000
Subject: [Intel-wired-lan] [PATCH v1] igc: Add set_rx_mode support
In-Reply-To: <20190910070512.31391-1-sasha.neftin@intel.com>
References: <20190910070512.31391-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B971184E5@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2019-09-10 at 10:05 +0300, Sasha Neftin wrote:
> Add multicast addresses list to the MTA table.
> Implement promiscious mode and add basic rx mode support.
> Add option for ipv6 address settings.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |   4 +
>  drivers/net/ethernet/intel/igc/igc_base.c    |   1 +
>  drivers/net/ethernet/intel/igc/igc_defines.h |   6 +
>  drivers/net/ethernet/intel/igc/igc_hw.h      |   2 +
>  drivers/net/ethernet/intel/igc/igc_mac.c     | 125 +++++++++++-
>  drivers/net/ethernet/intel/igc/igc_mac.h     |   3 +
>  drivers/net/ethernet/intel/igc/igc_main.c    | 271 +++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_regs.h    |   2 +
>  8 files changed, 413 insertions(+), 1 deletion(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
