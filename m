From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Sat, 9 Nov 2019 00:01:29 +0000
Subject: [Intel-wired-lan] [PATCH net 1/2] i40e: need_wakeup flag might
 not be set for Tx
In-Reply-To: <1573243090-2721-1-git-send-email-magnus.karlsson@intel.com>
References: <1573243090-2721-1-git-send-email-magnus.karlsson@intel.com>
Message-ID: <b168cadcfda241fdad05b6919b075333@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Magnus Karlsson
> Sent: Friday, November 8, 2019 11:58 AM
> To: Karlsson, Magnus <magnus.karlsson@intel.com>; Topel, Bjorn
> <bjorn.topel@intel.com>; intel-wired-lan at lists.osuosl.org
> Cc: maciejromanfijalkowski at gmail.com; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net 1/2] i40e: need_wakeup flag might not
> be set for Tx
> 
> The need_wakeup flag for Tx might not be set for AF_XDP sockets that are
> only used to send packets. This happens if there is at least one outstanding
> packet that has not been completed by the hardware and we get that
> corresponding completion (which will not generate an interrupt since
> interrupts are disabled in the napi poll loop) between the time we stopped
> processing the Tx completions and interrupts are enabled again. In this case,
> the need_wakeup flag will have been cleared at the end of the Tx
> completion processing as we believe we will get an interrupt from the
> outstanding completion at a later point in time. But if this completion
> interrupt occurs before interrupts are enable, we lose it and should at that
> point really have set the need_wakeup flag since there are no more
> outstanding completions that can generate an interrupt to continue the
> processing. When this happens, user space will see a Tx queue
> need_wakeup of 0 and skip issuing a syscall, which means will never get into
> the Tx processing again and we have a deadlock.
> 
> This patch introduces a quick fix for this issue by just setting the
> need_wakeup flag for Tx to 1 all the time. I am working on a proper fix for
> this that will toggle the flag appropriately, but it is more challenging than I
> anticipated and I am afraid that this patch will not be completed before the
> merge window closes, therefore this easier fix for now. This fix has a
> negative performance impact in the range of 0% to 4%. Towards the higher
> end of the scale if you have driver and application on the same core and issue
> a lot of packets, and towards no negative impact if you use two cores, lower
> transmission speeds and/or a workload that also receives packets.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


