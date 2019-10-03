From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 3 Oct 2019 02:46:13 +0000
Subject: [Intel-wired-lan] [PATCH v2] igc: Add set_rx_mode support
In-Reply-To: <20190925085853.1080-1-sasha.neftin@intel.com>
References: <20190925085853.1080-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9713443A@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of
> Sasha Neftin
> Sent: Wednesday, September 25, 2019 1:59 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2] igc: Add set_rx_mode support
> 
> Add multicast addresses list to the MTA table.
> Implement basic rx mode support.
> Add option for ipv6 address settings.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h |   3 +
>  drivers/net/ethernet/intel/igc/igc_hw.h      |   1 +
>  drivers/net/ethernet/intel/igc/igc_mac.c     | 104 +++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_mac.h     |   2 +
>  drivers/net/ethernet/intel/igc/igc_main.c    | 181
> +++++++++++++++++++++++++++
>  5 files changed, 291 insertions(+)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
