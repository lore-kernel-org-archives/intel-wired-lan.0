From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 Feb 2019 23:16:14 +0000
Subject: [Intel-wired-lan] [PATCH S14 06/15] ice: Limit the
 ice_add_rx_frag to frag addition
In-Reply-To: <20190213185115.25877-7-anirudh.venkataramanan@intel.com>
References: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
 <20190213185115.25877-7-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D36715C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, February 13, 2019 10:51 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S14 06/15] ice: Limit the ice_add_rx_frag to
> frag addition
> 
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> Refactor ice_fetch_rx_buf and ice_add_rx_frag in a way that we have
> standalone functions that do either the skb construction or frag addition to
> previously constructed skb.
> 
> The skb handling between rx_bufs is spread among various functions. The
> ice_get_rx_buf will retrieve the skb pointer from rx_buf and if it is a NULL
> pointer then we do the ice_construct_skb, otherwise we add a frag to the
> current skb via ice_add_rx_frag. Then, on the ice_put_rx_buf the skb
> pointer that belongs to rx_buf will be cleared. Moving further, if the current
> frame is not EOP frame we assign the current skb to the rx_buf that is
> pointed by updated next_to_clean indicator.
> 
> What is more during the buffer reuse let's assign each member of ice_rx_buf
> individually so we avoid the unnecessary copy of skb.
> 
> Last but not least, this logic split will allow us for better code reuse when
> adding a support for build_skb.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 160 +++++++++++++++-----------
> ----
>  1 file changed, 79 insertions(+), 81 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


