From: Kuruvinakunnel, George <george.kuruvinakunnel@intel.com>
Date: Fri, 18 Feb 2022 08:35:52 +0000
Subject: [Intel-wired-lan] [PATCH net-next 1/2] i40e: remove dead stores
 on XSK hotpath
In-Reply-To: <20211130183649.1166842-1-alexandr.lobakin@intel.com>
References: <20211130183649.1166842-1-alexandr.lobakin@intel.com>
Message-ID: <PH0PR11MB5144743C1D59676DB4E234B3E2379@PH0PR11MB5144.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Lobakin,
> Alexandr
> Sent: Wednesday, December 1, 2021 12:07 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: linux-kernel at vger.kernel.org; Jesper Dangaard Brouer <hawk@kernel.org>;
> Daniel Borkmann <daniel@iogearbox.net>; netdev at vger.kernel.org;
> bpf at vger.kernel.org; John Fastabend <john.fastabend@gmail.com>; Alexei
> Starovoitov <ast@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Dumitrescu,
> Cristian <cristian.dumitrescu@intel.com>; David S. Miller <davem@davemloft.net>;
> Karlsson, Magnus <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next 1/2] i40e: remove dead stores on XSK
> hotpath
> 
> The 'if (ntu == rx_ring->count)' block in i40e_alloc_rx_buffers_zc() was previously
> residing in the loop, but after introducing the batched interface it is used only to wrap-
> around the NTU descriptor, thus no more need to assign 'xdp'.
> 
> 'cleaned_count' in i40e_clean_rx_irq_zc() was previously being incremented in the
> loop, but after commit f12738b6ec06
> ("i40e: remove unnecessary cleaned_count updates") it gets assigned only once after
> it, so the initialization can be dropped.
> 
> Fixes: 6aab0bb0c5cd ("i40e: Use the xsk batched rx allocation interface")
> Fixes: f12738b6ec06 ("i40e: remove unnecessary cleaned_count updates")
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>
