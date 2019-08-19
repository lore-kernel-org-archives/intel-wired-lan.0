From: Laatz, Kevin <kevin.laatz@intel.com>
Date: Mon, 19 Aug 2019 15:47:52 +0100
Subject: [Intel-wired-lan] [PATCH bpf-next v4 07/11] mlx5e: modify
 driver for handling offsets
In-Reply-To: <390f80fc-3f8a-a9ed-6ac7-8a1a41621559@mellanox.com>
References: <20190724051043.14348-1-kevin.laatz@intel.com>
 <20190730085400.10376-1-kevin.laatz@intel.com>
 <20190730085400.10376-8-kevin.laatz@intel.com>
 <bc0c966f-4cda-4d48-566f-f5bff376210a@mellanox.com>
 <390f80fc-3f8a-a9ed-6ac7-8a1a41621559@mellanox.com>
Message-ID: <68cc44b5-7846-ec0b-4cb1-99dbe7faabcc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 19/08/2019 15:36, Maxim Mikityanskiy wrote:
> On 2019-08-01 13:05, Maxim Mikityanskiy wrote:
>> On 2019-07-30 11:53, Kevin Laatz wrote:
>>> With the addition of the unaligned chunks option, we need to make sure we
>>> handle the offsets accordingly based on the mode we are currently running
>>> in. This patch modifies the driver to appropriately mask the address for
>>> each case.
>>>
>>> Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
>> Please note that this patch doesn't actually add the support for the new
>> feature, because the validation checks in mlx5e_rx_get_linear_frag_sz
>> and mlx5e_validate_xsk_param need to be relaxed. Currently the frame
>> size of PAGE_SIZE is forced, and the fragment size is increased to
>> PAGE_SIZE in case of XDP (including XSK).
>>
>> After making the changes required to permit frame sizes smaller than
>> PAGE_SIZE, our Striding RQ feature will be used in a way we haven't used
>> it before, so we need to verify with the hardware team that this usage
>> is legitimate.
> After discussing it internally, we found a way to support unaligned XSK
> with Striding RQ, and the hardware is compatible with this way. I have
> performed some testing, and it looks working.
Great news! :-)
>
> Your patch only adds support for the new handle format to our driver,
> and I've made another patch that actually enables the new feature (makes
> mlx5e accept frame sizes different from PAGE_SIZE). It's currently on
> internal review.
Thanks for taking the time to prepare the patch!
>
> Please also don't forget to fix the s/_handle_/_adjust_/ typo.

I have fixed it in the next version (also currently on internal review).

Regards,

Kevin

>
>>> ---
>>> v3:
>>>  ?? - Use new helper function to handle offset
>>>
>>> v4:
>>>  ?? - fixed headroom addition to handle. Using xsk_umem_adjust_headroom()
>>>  ???? now.
>>> ---
>>>  ? drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c??? | 8 ++++++--
>>>  ? drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c | 3 ++-
>>>  ? 2 files changed, 8 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
>>> b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
>>> index b0b982cf69bb..d5245893d2c8 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
>>> @@ -122,6 +122,7 @@ bool mlx5e_xdp_handle(struct mlx5e_rq *rq, struct
>>> mlx5e_dma_info *di,
>>>  ??????????????? void *va, u16 *rx_headroom, u32 *len, bool xsk)
>>>  ? {
>>>  ????? struct bpf_prog *prog = READ_ONCE(rq->xdp_prog);
>>> +??? struct xdp_umem *umem = rq->umem;
>>>  ????? struct xdp_buff xdp;
>>>  ????? u32 act;
>>>  ????? int err;
>>> @@ -138,8 +139,11 @@ bool mlx5e_xdp_handle(struct mlx5e_rq *rq, struct
>>> mlx5e_dma_info *di,
>>>  ????? xdp.rxq = &rq->xdp_rxq;
>>>  ????? act = bpf_prog_run_xdp(prog, &xdp);
>>> -??? if (xsk)
>>> -??????? xdp.handle += xdp.data - xdp.data_hard_start;
>>> +??? if (xsk) {
>>> +??????? u64 off = xdp.data - xdp.data_hard_start;
>>> +
>>> +??????? xdp.handle = xsk_umem_handle_offset(umem, xdp.handle, off);
>>> +??? }
>>>  ????? switch (act) {
>>>  ????? case XDP_PASS:
>>>  ????????? *rx_headroom = xdp.data - xdp.data_hard_start;
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
>>> b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
>>> index 6a55573ec8f2..7c49a66d28c9 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
>>> @@ -24,7 +24,8 @@ int mlx5e_xsk_page_alloc_umem(struct mlx5e_rq *rq,
>>>  ????? if (!xsk_umem_peek_addr_rq(umem, &handle))
>>>  ????????? return -ENOMEM;
>>> -??? dma_info->xsk.handle = handle + rq->buff.umem_headroom;
>>> +??? dma_info->xsk.handle = xsk_umem_adjust_offset(umem, handle,
>>> +????????????????????????????? rq->buff.umem_headroom);
>>>  ????? dma_info->xsk.data = xdp_umem_get_data(umem, dma_info->xsk.handle);
>>>  ????? /* No need to add headroom to the DMA address. In striding RQ
>>> case, we
>>>
