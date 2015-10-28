From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Oct 2015 19:26:20 +0000
Subject: [Intel-wired-lan] [next PATCH S20 03/15] i40e/i40evf: Fix RS
 bit	update in Tx path and disable force WB workaround
In-Reply-To: <1445903081-155893-4-git-send-email-catherine.sullivan@intel.com>
References: <1445903081-155893-1-git-send-email-catherine.sullivan@intel.com>
 <1445903081-155893-4-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D4787@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, October 26, 2015 4:44 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S20 03/15] i40e/i40evf: Fix RS bit
> update in Tx path and disable force WB workaround
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> This patch fixes the issue of forcing WB too often causing us to not benefit
> from NAPI.
> 
> Without this patch we were forcing WB/arming interrupt too often taking
> away the benefits of NAPI and causing a performance impact.
> 
> With this patch we disable force WB in the clean routine for X710 and XL710
> adapters. X722 adapters do not enable interrupt to force a WB and benefit
> from WB_ON_ITR and hence force WB is left enabled for those adapters.
> For XL710 and X710 adapters if we have less than 4 packets pending a
> software Interrupt triggered from service task will force a WB.
> 
> This patch also changes the conditions for setting RS bit as described in code
> comments. This optimizes when the HW does a tail bump amd when it does a
> WB. It also optimizes when we do a wmb.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: Id831e1ae7d3e2ec3f52cd0917b41ce1d22d75d9d
> 
> ---
> Testing-hints: Test with heavy receive side traffic and you should see a lower
> interrupt rate, lower CPU utilization, lower packet latency, and higher
> transmit throughput.
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 118 ++++++++++++++++----
> ------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h |   2 +
>  2 files changed, 77 insertions(+), 43 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, lower cpu utilization, lower latency, and higher throughput seen with patch applied.
