From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 21 Aug 2018 21:31:53 +0000
Subject: [Intel-wired-lan] [PATCH v4 06/13] ice: Fix bugs in control
 queue processing
In-Reply-To: <20180809132903.22819-7-anirudh.venkataramanan@intel.com>
References: <20180809132903.22819-1-anirudh.venkataramanan@intel.com>
 <20180809132903.22819-7-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD2619545A96@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, August 9, 2018 6:29 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v4 06/13] ice: Fix bugs in control queue
> processing
> 
> This patch is a consolidation of multiple bug fixes for control queue
> processing.
> 
> 1)  In ice_clean_adminq_subtask() remove unnecessary reads/writes to
>     registers. The bits PFINT_FW_CTL, PFINT_MBX_CTL and PFINT_SB_CTL
>     are not set when an interrupt arrives, which means that clearing them
>     again can be omitted.
> 
> 2)  Get an accurate value in "pending" by re-reading the control queue
>     head register from the hardware.
> 
> 3)  Fix a corner case involving lost control queue messages by checking
>     for new control messages (using ice_ctrlq_pending) before exiting the
>     cleanup routine.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_controlq.c |  5 +++-
>  drivers/net/ethernet/intel/ice/ice_main.c     | 26 ++++++++++++++++---
>  2 files changed, 26 insertions(+), 5 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


