From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Thu, 19 Aug 2021 00:10:25 +0300
Subject: [Intel-wired-lan] [PATCH next-queue v3 2/3] igc: Simplify TSN
 flags handling
In-Reply-To: <1628520820-28907-3-git-send-email-aravindhan.gunasekaran@intel.com>
References: <1628520820-28907-1-git-send-email-aravindhan.gunasekaran@intel.com>
 <1628520820-28907-3-git-send-email-aravindhan.gunasekaran@intel.com>
Message-ID: <bfe33b15-adb3-153a-927e-0e8bf2b536e8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/9/2021 17:53, aravindhan.gunasekaran at intel.com wrote:
> From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> 
> Separates the procedure done during reset from applying a
> configuration, knowing when the code is executing allow us to
> separate the better what changes the hardware state from what
> changes only the driver state.
> 
> Introduces a flag for bookkeeping the driver state of TSN
> features. When Qav and frame-preemption is also implemented
> this flag makes it easier to keep track on whether a TSN feature
> driver state is enabled or not though controller state changes,
> say,during a reset.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Aravindhan Gunasekaran <aravindhan.gunasekaran@intel.com>
> Signed-off-by: Mallikarjuna Chilakala <mallikarjuna.chilakala@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h      |  2 +
>   drivers/net/ethernet/intel/igc/igc_main.c |  2 +-
>   drivers/net/ethernet/intel/igc/igc_tsn.c  | 65 ++++++++++++++++++-------------
>   drivers/net/ethernet/intel/igc/igc_tsn.h  |  1 +
>   4 files changed, 43 insertions(+), 27 deletions(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
