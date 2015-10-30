From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 30 Oct 2015 09:11:07 -0700
Subject: [Intel-wired-lan] [net PATCH 3/3] ixgbe: Fix handling of napi
 budget when multiple queues are enabled per vector
In-Reply-To: <CAJ75kXZx9YoD4_k7yb2aEomhxceG96D-twPqYz_-9QmY-2MXvw@mail.gmail.com>
References: <20150922213002.2774.37924.stgit@ahduyck-vm-fedora22>
 <20150922213541.2774.70538.stgit@ahduyck-vm-fedora22>
 <CAJ75kXZx9YoD4_k7yb2aEomhxceG96D-twPqYz_-9QmY-2MXvw@mail.gmail.com>
Message-ID: <5633969B.1050401@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/30/2015 07:55 AM, William Dauchy wrote:
> Hi Alexander,
>
> On Tue, Sep 22, 2015 at 11:35 PM, Alexander Duyck <aduyck@mirantis.com> wrote:
>> This patch corrects an issue in which the polling routine would increase
>> the budget for Rx to at least 1 per queue if multiple queues were present.
>> This would result in Rx packets being processed when the budget was 0 which
>> is meant to indicate that no Rx can be handled.
> We may logically have the same issue with VF, right?
>
>  From 4521374ae746543a925982d59a8ba73b6aaee59c Mon Sep 17 00:00:00 2001
> From: William Dauchy <william@gandi.net>
> Date: Fri, 30 Oct 2015 15:48:43 +0100
> Subject: [PATCH] ixgbevf: Fix handling of napi budget when multiple queues are
>   enabled per vector
>
> This is the same patch as for ixgbe but applied differently according to
> busy polling
>
> Signed-off-by: William Dauchy <william@gandi.net>
> ---
>   drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index 149a0b4..ff6e21d 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -1014,6 +1014,8 @@ static int ixgbevf_poll(struct napi_struct
> *napi, int budget)
>    ixgbevf_for_each_ring(ring, q_vector->tx)
>    clean_complete &= ixgbevf_clean_tx_irq(q_vector, ring);
>
> + if (budget <= 0)
> + return budget;
>   #ifdef CONFIG_NET_RX_BUSY_POLL
>    if (!ixgbevf_qv_lock_napi(q_vector))
>    return budget;

Yes the same issue applies to ixgbevf, but it looks like your patch was 
mangled by your mail client.  Can you please resubmit with the white 
spaces fixed?

- Alex
