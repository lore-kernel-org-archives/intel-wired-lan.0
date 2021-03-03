From: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
Date: Wed, 3 Mar 2021 10:08:17 +0200
Subject: [Intel-wired-lan] [PATCH net v1 0/2] igc: Fix Pause Frame
 Advertising
In-Reply-To: <20210219163648.14581-1-muhammad.husaini.zulkifli@intel.com>
References: <20210219163648.14581-1-muhammad.husaini.zulkifli@intel.com>
Message-ID: <25ceda96-4835-0bec-e3b9-e5bf5edd6adf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 19/02/2021 18:36, Muhammad Husaini Zulkifli wrote:
> Hi,
> 
> Kindly help to review below patches.
> 
> Summary of each patches as per below:
> Patch 1: To fix "Advertised pause frame use" advertising when tx and rx are in off state with AutoNegotiate off.
> Patch 2: To fix "Supported pause frame use" output via ethtool where the bit is not set.
> 
> Tested with Intel? Ethernet Controller I225(Rev4).
> 
> Thanks.
> 
> Muhammad Husaini Zulkifli (2):
>    igc: Fix Pause Frame Advertising
>    igc: Fix Supported Pause Frame Link Setting
> 
>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> --
> 2.17.1
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
