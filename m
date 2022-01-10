From: Bhandare, KiranX <kiranx.bhandare@intel.com>
Date: Mon, 10 Jan 2022 10:31:26 +0000
Subject: [Intel-wired-lan] [PATCH v3 net-next 2/9] i40e: respect
 metadata on XSK Rx to skb
In-Reply-To: <20211207205536.563550-3-alexandr.lobakin@intel.com>
References: <20211207205536.563550-1-alexandr.lobakin@intel.com>
 <20211207205536.563550-3-alexandr.lobakin@intel.com>
Message-ID: <DM6PR11MB32929AFBEAB5A2F42AC17543F1509@DM6PR11MB3292.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Lobakin, Alexandr
> Sent: Wednesday, December 8, 2021 2:25 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Andre Guedes <andre.guedes@intel.com>; Jesper Dangaard Brouer
> <hawk@kernel.org>; Daniel Borkmann <daniel@iogearbox.net>;
> netdev at vger.kernel.org; Krzysztof Kazimierczak
> <krzysztof.kazimierczak@intel.com>; bpf at vger.kernel.org; John Fastabend
> <john.fastabend@gmail.com>; Alexei Starovoitov <ast@kernel.org>; Brouer,
> Jesper <brouer@redhat.com>; Bj?rn T?pel <bjorn@kernel.org>; Jeff Kirsher
> <jeffrey.t.kirsher@intel.com>; Jakub Kicinski <kuba@kernel.org>; linux-
> kernel at vger.kernel.org; David S. Miller <davem@davemloft.net>; Vedang
> Patel <vedang.patel@intel.com>
> Subject: [Intel-wired-lan] [PATCH v3 net-next 2/9] i40e: respect metadata on
> XSK Rx to skb
> 
> For now, if the XDP prog returns XDP_PASS on XSK, the metadata will be lost
> as it doesn't get copied to the skb.
> Copy it along with the frame headers. Account its size on skb allocation, and
> when copying just treat it as a part of the frame and do a pull after to "move"
> it to the "reserved" zone.
> net_prefetch() xdp->data_meta and align the copy size to speed-up
> memcpy() a little and better match i40e_costruct_skb().
> 
> Fixes: 0a714186d3c0 ("i40e: add AF_XDP zero-copy Rx support")
> Suggested-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 

Tested-by: Kiran Bhandare <kiranx.bhandare@intel.com>  A Contingent Worker at Intel
