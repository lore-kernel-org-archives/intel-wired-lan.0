From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Jul 2020 17:49:12 +0000
Subject: [Intel-wired-lan] [PATCH S50 10/15] ice: need_wakeup flag might
 not be set for Tx
In-Reply-To: <20200713205318.32425-10-anthony.l.nguyen@intel.com>
References: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
 <20200713205318.32425-10-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB2145E3E2CA3C7A69CF49C37C8C7F0@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Monday, July 13, 2020 1:53 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S50 10/15] ice: need_wakeup flag might
> not be set for Tx
> 
> From: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
> 
> This is a port of i40e commit 705639572e8c ("i40e: need_wakeup flag might
> not be set for Tx").
> 
> Quoting the original commit message:
> 
> "The need_wakeup flag for Tx might not be set for AF_XDP sockets that are
> only used to send packets. This happens if there is at least one outstanding
> packet that has not been completed by the hardware and we get that
> corresponding completion (which will not generate an interrupt since
> interrupts are disabled in the napi poll loop) between the time we stopped
> processing the Tx completions and interrupts are enabled again.
> In this case, the need_wakeup flag will have been cleared at the end of the
> Tx completion processing as we believe we will get an interrupt from the
> outstanding completion at a later point in time. But if this completion
> interrupt occurs before interrupts are enable, we lose it and should at that
> point really have set the need_wakeup flag since there are no more
> outstanding completions that can generate an interrupt to continue the
> processing. When this happens, user space will see a Tx queue
> need_wakeup of 0 and skip issuing a syscall, which means will never get into
> the Tx processing again and we have a deadlock."
> 
> As a result, packet processing stops. This patch introduces a fix for this issue,
> by always setting the need_wakeup flag at the end of an interrupt
> processing. This ensures that the deadlock will not happen.
> 
> Signed-off-by: Krzysztof Kazimierczak <krzysztof.kazimierczak@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_xsk.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


