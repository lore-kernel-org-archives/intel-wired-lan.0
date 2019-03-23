From: Mukesh Ojha <mojha@codeaurora.org>
Date: Sat, 23 Mar 2019 15:38:59 +0530
Subject: [Intel-wired-lan] [PATCH] net: fm10k: fix a potential NULL
 pointer dereference
In-Reply-To: <20190311061732.19064-1-kjlu@umn.edu>
References: <20190311061732.19064-1-kjlu@umn.edu>
Message-ID: <bfd5bbb7-0f9a-dd97-d0c3-22ba00567b79@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 3/11/2019 11:47 AM, Kangjie Lu wrote:
> In case alloc_workqueue fails, the fix returns -ENOMEM to avoid
> potential NULL pointer dereference.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>   drivers/net/ethernet/intel/fm10k/fm10k_main.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> index 5a0419421511..215f232674f1 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> @@ -41,6 +41,8 @@ static int __init fm10k_init_module(void)
>   	/* create driver workqueue */
>   	fm10k_workqueue = alloc_workqueue("%s", WQ_MEM_RECLAIM, 0,
>   					  fm10k_driver_name);
> +	if (unlikely(!fm10k_workqueue))
> +		return -ENOMEM;
>   
>   	fm10k_dbg_init();
>   


Reviewed-by: Mukesh Ojha <mojha at codeaurora.org 
<mailto:mojha@codeaurora.org>>

Thanks.
Mukesh

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190323/fbcf97ef/attachment.html>
