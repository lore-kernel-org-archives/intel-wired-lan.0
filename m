From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Fri, 4 Sep 2020 17:54:42 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 6/6] ixgbe,
 xsk: finish napi loop if AF_XDP Rx queue is full
In-Reply-To: <20200904173540.3a617eee@carbon>
References: <20200904135332.60259-1-bjorn.topel@gmail.com>
 <20200904135332.60259-7-bjorn.topel@gmail.com>
 <20200904173540.3a617eee@carbon>
Message-ID: <59da4aa6-dbc5-b366-e84e-0030f6010e55@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2020-09-04 17:35, Jesper Dangaard Brouer wrote:
> On Fri,  4 Sep 2020 15:53:31 +0200
> Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
> 
>> From: Bj?rn T?pel <bjorn.topel@intel.com>
>>
>> Make the AF_XDP zero-copy path aware that the reason for redirect
>> failure was due to full Rx queue. If so, exit the napi loop as soon as
>> possible (exit the softirq processing), so that the userspace AF_XDP
>> process can hopefully empty the Rx queue. This mainly helps the "one
>> core scenario", where the userland process and Rx softirq processing
>> is on the same core.
>>
>> Note that the early exit can only be performed if the "need wakeup"
>> feature is enabled, because otherwise there is no notification
>> mechanism available from the kernel side.
>>
>> This requires that the driver starts using the newly introduced
>> xdp_do_redirect_ext() and xsk_do_redirect_rx_full() functions.
>>
>> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
>> ---
>>   drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 23 ++++++++++++++------
>>   1 file changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
>> index 3771857cf887..a4aebfd986b3 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
>> @@ -93,9 +93,11 @@ int ixgbe_xsk_pool_setup(struct ixgbe_adapter *adapter,
>>   
>>   static int ixgbe_run_xdp_zc(struct ixgbe_adapter *adapter,
>>   			    struct ixgbe_ring *rx_ring,
>> -			    struct xdp_buff *xdp)
>> +			    struct xdp_buff *xdp,
>> +			    bool *early_exit)
>>   {
>>   	int err, result = IXGBE_XDP_PASS;
>> +	enum bpf_map_type map_type;
>>   	struct bpf_prog *xdp_prog;
>>   	struct xdp_frame *xdpf;
>>   	u32 act;
>> @@ -116,8 +118,13 @@ static int ixgbe_run_xdp_zc(struct ixgbe_adapter *adapter,
>>   		result = ixgbe_xmit_xdp_ring(adapter, xdpf);
>>   		break;
>>   	case XDP_REDIRECT:
>> -		err = xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
>> -		result = !err ? IXGBE_XDP_REDIR : IXGBE_XDP_CONSUMED;
>> +		err = xdp_do_redirect_ext(rx_ring->netdev, xdp, xdp_prog, &map_type);
>> +		if (err) {
>> +			*early_exit = xsk_do_redirect_rx_full(err, map_type);
> 
> Have you tried calling xdp_do_flush (that calls __xsk_map_flush()) and
> (I guess) xsk_set_rx_need_wakeup() here, instead of stopping the loop?
> (Or doing this in xsk core).
>

Moving the need_wake logic to the xsk core/flush would be a very nice
cleanup. The driver would still need to pass information from the driver
though. Still, much cleaner. I'll take a stab at that. Thanks!


> Looking at the code, the AF_XDP frames are "published" in the queue
> rather late for AF_XDP.  Maybe in an orthogonal optimization, have you
> considered "publishing" the ring producer when e.g. the queue is
> half-full?
>

Hmm, I haven't. You mean instead of yielding, you publish/submit? I
*think* I still prefer stopping the processing.

I'll play with this a bit!

Very nice suggestions, Jesper! Thanks!


Bj?rn
