From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 6 Apr 2017 21:50:19 +0000
Subject: [Intel-wired-lan] [next S66 v2 10/11] i40e/i40evf: Add support
 for	padding start of frames
In-Reply-To: <20170405115103.67374-10-alice.michael@intel.com>
References: <20170405115103.67374-1-alice.michael@intel.com>
 <20170405115103.67374-10-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040B1A0@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 5, 2017 4:51 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next S66 v2 10/11] i40e/i40evf: Add support for
> padding start of frames
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch adds padding to the start of frames to make room for headroom
> for us to eventually start using build_skb.  Right now we guarantee at least
> NET_SKB_PAD + NET_IP_ALIGN, however we allocate more space if more is
> available.  For example on x86 the headroom should be 192 bytes.
> 
> On systems that have too large of a cache line size to support storing 1.5K
> padding and shared info we default to using 3K buffers and reserve
> everything that isn't used for skb_shared_info or the data buffer for
> headroom.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: I33c641c9a1ea10cf7cc484c2d20985368d2d709a
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c     |  9 +++-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c     | 15 +++++-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h     | 70
> ++++++++++++++++++++++++-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c   | 15 +++++-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h   | 70
> ++++++++++++++++++++++++-
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c |  8 ++-
>  6 files changed, 179 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


