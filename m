From: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
Date: Mon, 24 May 2021 12:57:42 +0300
Subject: [Intel-wired-lan] [PATCH v1] igc: Enable HW VLAN Insertion and
 HW VLAN Stripping
In-Reply-To: <20210510053612.14163-1-muhammad.husaini.zulkifli@intel.com>
References: <20210510053612.14163-1-muhammad.husaini.zulkifli@intel.com>
Message-ID: <fac887be-b481-c3a9-f6c9-a1dc58ed0abb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/05/2021 08:36, Muhammad Husaini Zulkifli wrote:
> Add HW VLAN acceleration protocol handling. In case of HW VLAN tagging,
> we need that protocol available in the ndo_start_xmit(), so that it will be
> stored in a new fields in the skb.
> 
> HW offloading is set to OFF by default.
> Users are allow to turn on/off rx/tx HW vlan acceleration via ethtool.
> 
> Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h         |  1 +
>   drivers/net/ethernet/intel/igc/igc_defines.h |  5 ++
>   drivers/net/ethernet/intel/igc/igc_main.c    | 73 +++++++++++++++++++-
>   drivers/net/ethernet/intel/igc/igc_regs.h    |  1 +
>   4 files changed, 78 insertions(+), 2 deletions(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
