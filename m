From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 Feb 2019 23:02:08 +0000
Subject: [Intel-wired-lan] [PATCH S14 04/15] ice: Introduce bulk update
 for page count
In-Reply-To: <20190213185115.25877-5-anirudh.venkataramanan@intel.com>
References: <20190213185115.25877-1-anirudh.venkataramanan@intel.com>
 <20190213185115.25877-5-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3670F8@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S14 04/15] ice: Introduce bulk update for
> page count
> 
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> {get,put}_page are atomic operations which we use for page count handling.
> The current logic for refcount handling is that we increment it when passing a
> skb with the data from the first half of page up to netstack and recycle the
> second half of page. This operation protects us from losing a page since the
> network stack can decrement the refcount of page from skb.
> 
> The performance can be gently improved by doing the bulk updates of
> refcount instead of doing it one by one. During the buffer initialization,
> maximize the page's refcount and don't allow the refcount to become less
> than two.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 26 +++++++++++++++++++------
> -  drivers/net/ethernet/intel/ice/ice_txrx.h |  1 +
>  2 files changed, 20 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


