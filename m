From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Fri, 23 Aug 2019 08:10:25 +0200
Subject: [Intel-wired-lan] [PATCH net v3] ixgbe: fix double clean of tx
 descriptors with xdp
In-Reply-To: <CALDO+SYhU4krmBO8d4hsDGm+BuUAR4qMv=WzVa=jAx27+g9KnA@mail.gmail.com>
References: <CGME20190822171243eucas1p12213f2239d6c36be515dade41ed7470b@eucas1p1.samsung.com>
 <20190822171237.20798-1-i.maximets@samsung.com>
 <CAKgT0UepBGqx=FiqrdC-r3kvkMxVAHonkfc6rDt_HVQuzahZPQ@mail.gmail.com>
 <CALDO+SYhU4krmBO8d4hsDGm+BuUAR4qMv=WzVa=jAx27+g9KnA@mail.gmail.com>
Message-ID: <217e90f5-206a-bb80-6699-f6dd750b57d9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2019-08-22 19:32, William Tu wrote:
> On Thu, Aug 22, 2019 at 10:21 AM Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
>>
>> On Thu, Aug 22, 2019 at 10:12 AM Ilya Maximets <i.maximets@samsung.com> wrote:
>>>
>>> Tx code doesn't clear the descriptors' status after cleaning.
>>> So, if the budget is larger than number of used elems in a ring, some
>>> descriptors will be accounted twice and xsk_umem_complete_tx will move
>>> prod_tail far beyond the prod_head breaking the completion queue ring.
>>>
>>> Fix that by limiting the number of descriptors to clean by the number
>>> of used descriptors in the tx ring.
>>>
>>> 'ixgbe_clean_xdp_tx_irq()' function refactored to look more like
>>> 'ixgbe_xsk_clean_tx_ring()' since we're allowed to directly use
>>> 'next_to_clean' and 'next_to_use' indexes.
>>>
>>> Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
>>> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
>>> ---
>>>
>>> Version 3:
>>>    * Reverted some refactoring made for v2.
>>>    * Eliminated 'budget' for tx clean.
>>>    * prefetch returned.
>>>
>>> Version 2:
>>>    * 'ixgbe_clean_xdp_tx_irq()' refactored to look more like
>>>      'ixgbe_xsk_clean_tx_ring()'.
>>>
>>>   drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 29 ++++++++------------
>>>   1 file changed, 11 insertions(+), 18 deletions(-)
>>
>> Thanks for addressing my concerns.
>>
>> Acked-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> Thanks.
> 
> Tested-by: William Tu <u9012063@gmail.com>
> 

Will, thanks for testing! For this patch, did you notice any performance
degradation?


Cheers,
Bj?rn
