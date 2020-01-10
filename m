From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 10 Jan 2020 00:23:30 +0000
Subject: [Intel-wired-lan] [PATCH v1] igc: Add support for TSO
In-Reply-To: <20200105122053.2512-1-sasha.neftin@intel.com>
References: <20200105122053.2512-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B971A9B8F@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Sasha
> Neftin
> Sent: Sunday, January 5, 2020 4:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1] igc: Add support for TSO
> 
> TCP segmentation offload allows a device to segment a single frame
> into multiple frames with a data payload size specified in socket buffer.
> As a result we can now send data approximately up to seven percents fast
> than was previously possible on my system.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h |   4 +
>  drivers/net/ethernet/intel/igc/igc_main.c    | 113
> ++++++++++++++++++++++++++-
>  2 files changed, 116 insertions(+), 1 deletion(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
