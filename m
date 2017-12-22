From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 Dec 2017 16:46:11 +0000
Subject: [Intel-wired-lan] [next PATCH S83-V5 6/9] i40e/i40evf: Detect
 and recover hung queue scenario
In-Reply-To: <20171218101725.75870-1-alice.michael@intel.com>
References: <20171218101725.75870-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8CAB41@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, December 18, 2017 2:17 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S83-V5 6/9] i40e/i40evf: Detect and
> recover hung queue scenario
> 
> From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> 
> In VFs, there is a known issue which can cause writebacks to not occur when
> interrupts are disabled and there are less than 4 descriptors resulting in TX
> timeout. Timeout can also occur due to lost interrupt.
> 
> The current implementation for detecting and recovering from hung queues
> in the PF is problematic because it actually actively encourages lost
> interrupts.  By triggering a SW interrupt, interrupts are forced on.  If we are
> already in napi_poll and an interrupt fires, napi_poll will not be rescheduled
> and the interrupt is effectively lost; thereby potentially *causing* hung
> queues.
> 
> This patch checks whether packets are being processed between every
> watchdog cycle and determine potential hung queue and fires triggers SW
> interrupt only for that particular queue.
> 
> Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 100 +-----------------------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c     |  54 +++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h     |   2 +
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c   |  54 +++++++++++++
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h   |   2 +
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c |   2 +
>  6 files changed, 115 insertions(+), 99 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


