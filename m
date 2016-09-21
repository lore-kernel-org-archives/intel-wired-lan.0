From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 21 Sep 2016 16:17:06 +0000
Subject: [Intel-wired-lan] [next PATCH S47 8/9] i40e/i40evf: fix
 interrupt	affinity bug
In-Reply-To: <1473895479-23035-9-git-send-email-bimmy.pujari@intel.com>
References: <1473895479-23035-1-git-send-email-bimmy.pujari@intel.com>
 <1473895479-23035-9-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0E48B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, September 14, 2016 4:25 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Brady, Alan <alan.brady@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S47 8/9] i40e/i40evf: fix interrupt
> affinity bug
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> There exists a bug in which a 'perfect storm' can occur and cause interrupts to
> fail to be correctly affinitized. This causes unexpected behavior and has a
> substantial impact on performance when it happens.
> 
> The bug occurs if there is heavy traffic, any number of CPUs that have an i40e
> interrupt are pegged at 100%, and the interrupt afffinity for those CPUs is
> changed.  Instead of moving to the new CPU, the interrupt continues to be
> polled while there is heavy traffic.
> 
> The bug is most readily realized as the driver is first brought up and all
> interrupts start on CPU0. If there is heavy traffic and the interrupt starts
> polling before the interrupt is affinitized, the interrupt will be stuck on CPU0
> until traffic stops. The bug, however, can also be wrought out more simply by
> affinitizing all the interrupts to a single CPU and then attempting to move any
> of those interrupts off while there is heavy traffic.
> 
> This patch fixes the bug by registering for update notifications from the
> kernel when the interrupt affinity changes. When that fires, we cache the
> intended affinity mask. Then, while polling, if the cpu is pegged at 100% and
> we failed to clean the rings, we check to make sure we have the correct
> affinity and stop polling if we're firing on the wrong CPU.  When the kernel
> successfully moves the interrupt, it will start polling on the correct CPU. The
> performance impact is minimal since the only time this section gets executed
> is when performance is already compromised by the CPU.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> Change-ID: I4410a880159b9dba1f8297aa72bef36dca34e830
> ---
> Testing-hints:
>     1.  Bring up ethx.
>     2.  Set affinity for all traffic interrupts to CPU0
>     3.  Start heavy traffic.
>     4.  Attempt to change affinity for any/all interrupts.
>         Expected:  IRQ correctly moves to the new cpu
>         Actual:  IRQ continues to poll on CPU0 and performance is
>                  severely impacted.
> 
>  drivers/net/ethernet/intel/i40e/i40e.h          |  2 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 64 +++++++++++++++++---
> --
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c     | 36 ++++++++++---
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c   | 31 +++++++++--
>  drivers/net/ethernet/intel/i40evf/i40evf.h      |  3 +-
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 71
> +++++++++++++++++--------
>  6 files changed, 159 insertions(+), 48 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Bug behavior no longer present


