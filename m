From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Fri, 7 May 2021 08:32:20 +0200
Subject: [Intel-wired-lan] [PATCH net] igb: fix netpoll exit with traffic
In-Reply-To: <20210507023001.2621951-1-jesse.brandeburg@intel.com>
References: <20210507023001.2621951-1-jesse.brandeburg@intel.com>
Message-ID: <20210507063220.x6w4ok2sujdlher6@spock.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello.

On Thu, May 06, 2021 at 07:30:01PM -0700, Jesse Brandeburg wrote:
> Oleksandr brought a bug report where netpoll causes trace messages in
> the log on igb.
> 
> [22038.710800] ------------[ cut here ]------------
> [22038.710801] igb_poll+0x0/0x1440 [igb] exceeded budget in poll
> [22038.710802] WARNING: CPU: 12 PID: 40362 at net/core/netpoll.c:155 netpoll_poll_dev+0x18a/0x1a0
> 
> After some discussion and debug from the list, it was deemed that the
> right thing to do is initialize the clean_complete variable to false
> when the "netpoll mode" of passing a zero budget is used.
> 
> This logic should be sane and not risky because the only time budget
> should be zero on entry is netpoll.  Change includes a small refactor
> of local variable assignments to clean up the look.
> 
> Fixes: 16eb8815c235 ("igb: Refactor clean_rx_irq to reduce overhead and improve performance")
> Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Suggested-by: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>

Thanks for the patch, I'll test it ASAP and ask other persons from the
bugzilla to provide a feedback if possible.

Also, you may want to include a link to the kernel bugzilla into the
commit message:

Link: https://bugzilla.kernel.org/show_bug.cgi?id=212573

> ---
> 
> Compile tested ONLY, but functionally it should be exactly the same for
> all cases except when budget is zero on entry, which will hopefully fix
> the bug.
> 
> Sending this through intel-wired-lan with Alex's ACK.
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 0cd37ad81b4e..b0a9bed14071 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -7991,12 +7991,16 @@ static void igb_ring_irq_enable(struct igb_q_vector *q_vector)
>   **/
>  static int igb_poll(struct napi_struct *napi, int budget)
>  {
> -	struct igb_q_vector *q_vector = container_of(napi,
> -						     struct igb_q_vector,
> -						     napi);
> -	bool clean_complete = true;
> +	struct igb_q_vector *q_vector;
> +	bool clean_complete;
>  	int work_done = 0;
>  
> +	/* if budget is zero, we have a special case for netconsole, so
> +	 * make sure to set clean_complete to false in that case.
> +	 */
> +	clean_complete = !!budget;
> +
> +	q_vector = container_of(napi, struct igb_q_vector, napi);
>  #ifdef CONFIG_IGB_DCA
>  	if (q_vector->adapter->flags & IGB_FLAG_DCA_ENABLED)
>  		igb_update_dca(q_vector);
> -- 
> 2.30.2
> 

-- 
  Oleksandr Natalenko (post-factum)
