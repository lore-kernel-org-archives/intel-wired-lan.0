From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Thu, 25 Nov 2021 08:03:18 +0100
Subject: [Intel-wired-lan] [PATCH net v2] igb: fix netpoll exit with
 traffic
In-Reply-To: <20211123204000.1597971-1-jesse.brandeburg@intel.com>
References: <20211123204000.1597971-1-jesse.brandeburg@intel.com>
Message-ID: <4695060.31r3eYUQgx@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello.

On ?ter? 23. listopadu 2021 21:40:00 CET Jesse Brandeburg wrote:
> Oleksandr brought a bug report where netpoll causes trace
> messages in the log on igb.
> 
> Danielle brought this back up as still occuring, so we'll try
> again.
> 
> [22038.710800] ------------[ cut here ]------------
> [22038.710801] igb_poll+0x0/0x1440 [igb] exceeded budget in poll
> [22038.710802] WARNING: CPU: 12 PID: 40362 at net/core/netpoll.c:155
> netpoll_poll_dev+0x18a/0x1a0
> 
> As Alex suggested, change the driver to return work_done at the
> exit of napi_poll, which should be safe to do in this driver
> because it is not polling multiple queues in this single napi
> context (multiple queues attached to one MSI-X vector). Several
> other drivers contain the same simple sequence, so I hope
> this will not create new problems.
> 
> Fixes: 16eb8815c235 ("igb: Refactor clean_rx_irq to reduce overhead and
> improve performance") Reported-by: Oleksandr Natalenko
> <oleksandr@natalenko.name>
> Reported-by: Danielle Ratson <danieller@nvidia.com>
> Suggested-by: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> COMPILE TESTED ONLY! I have no way to reproduce this even on a machine I
> have with igb. It works fine to load the igb driver and netconsole with
> no errors.
> ---
> v2: simplified patch with an attempt to make it work
> v1: original patch that apparently didn't work
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
> b/drivers/net/ethernet/intel/igb/igb_main.c index
> e647cc89c239..5e24b7ce5a92 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -8104,7 +8104,7 @@ static int igb_poll(struct napi_struct *napi, int
> budget) if (likely(napi_complete_done(napi, work_done)))
>  		igb_ring_irq_enable(q_vector);
> 
> -	return min(work_done, budget - 1);
> +	return work_done;
>  }
> 
>  /**

This seems to address the issue for me. I do not see a warning after a couple 
of suspend/resume cycles any more, while previously it occurred after the first 
cycle.

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

Thanks!

-- 
Oleksandr Natalenko (post-factum)


