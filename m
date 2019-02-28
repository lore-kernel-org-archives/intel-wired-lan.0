From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 Feb 2019 23:00:26 +0000
Subject: [Intel-wired-lan] [PATCH S14 03/15] ice: Get rid of
 ice_pull_tail
In-Reply-To: <20190213185115.25877-4-anirudh.venkataramanan@intel.com>
References: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
 <20190213185115.25877-4-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3670E8@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S14 03/15] ice: Get rid of ice_pull_tail
> 
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> Instead of adding a frag and later when dealing with EOP frame accessing
> that frag in order to copy the headers onto linear part of skb, we can do this
> in ice_add_rx_frag in case where the data_len is still 0 and frame won't fit
> onto the linear part as a whole.
> 
> Function comment of ice_pull_tail was a bit misleading because of
> mentioned optimizations that can be performed (drop a frag/maintaining
> accurate truesize of skb) - it seems that this part of logic was dropped and
> the comment was not updated to reflect this change.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 70 +++++++++++-------------------
> -
>  1 file changed, 24 insertions(+), 46 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


