From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 29 Oct 2015 21:57:35 +0000
Subject: [Intel-wired-lan] [next PATCH S19 07/15] i40e/i40evf: Add a
 stat to	track how many times we have to do a force WB
In-Reply-To: <1445471236-35918-8-git-send-email-catherine.sullivan@intel.com>
References: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
 <1445471236-35918-8-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D4B87@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Wednesday, October 21, 2015 4:47 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S19 07/15] i40e/i40evf: Add a stat to
> track how many times we have to do a force WB
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> When in NAPI with interrupts disabled, the HW needs to be forced to do a
> write back on TX if the number of descriptors pending are less than a cache
> line.
> 
> This stat helps keep track of how many times we get into this situation.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: I76c1bcc7ebccd6bffcc5aa33bfe05f2fa1c9a984
> 
> ---
> Testing-hints: We are forcing WB only once a second with the changes to
> move force WB in the timer task. You should not see this ethtool stat
> "tx_force_wb" go up more often than that on X[L]710. On TLVF you will see
> this stat more ofetn since we have a different strategy for force WB since the
> HW provides a less expensive way of doing a force WB.
>  drivers/net/ethernet/intel/i40e/i40e.h         | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 5 ++++-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 4 +++-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h    | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c  | 4 +++-
> drivers/net/ethernet/intel/i40evf/i40e_txrx.h  | 1 +
>  7 files changed, 14 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, stats correctly show up in Ethtool -S
