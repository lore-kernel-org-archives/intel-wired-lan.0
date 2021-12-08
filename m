From: Jesper Dangaard Brouer <jbrouer@redhat.com>
Date: Wed, 8 Dec 2021 14:47:35 +0100
Subject: [Intel-wired-lan] [PATCH v3 net-next 9/9] i40e: respect
 metadata on XSK Rx to skb
In-Reply-To: <20211207205536.563550-10-alexandr.lobakin@intel.com>
References: <20211207205536.563550-1-alexandr.lobakin@intel.com>
 <20211207205536.563550-10-alexandr.lobakin@intel.com>
Message-ID: <87463ddc-bf93-99cc-65d1-cbc215125ec3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 07/12/2021 21.55, Alexander Lobakin wrote:
> For now, if the XDP prog returns XDP_PASS on XSK, the metadata will
> be lost as it doesn't get copied to the skb.
> Copy it along with the frame headers. Account its size on skb
> allocation, and when copying just treat it as a part of the frame
> and do a pull after to "move" it to the "reserved" zone.
> net_prefetch() xdp->data_meta and align the copy size to speed-up
> memcpy() a little and better match ixgbee_costruct_skb().
                                      ^^^^^^^^^^^^^^^^^^^
Misspelling function name.

> 
> Fixes: d0bcacd0a130 ("ixgbe: add AF_XDP zero-copy Rx support")
> Suggested-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)

Wrong driver (i40e:) "tagged" in subject.

