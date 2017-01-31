From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 31 Jan 2017 17:35:46 +0000
Subject: [Intel-wired-lan] [next PATCH v2 08/11] ixgbe: Add support
	for	padding packet
In-Reply-To: <20170117163651.5423.70434.stgit@localhost.localdomain>
References: <20170117163401.5423.37993.stgit@localhost.localdomain>
 <20170117163651.5423.70434.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5D6C0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, January 17, 2017 8:37 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH v2 08/11] ixgbe: Add support for
> padding packet
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch adds support for providing a buffer with headroom and tailroom to
> allow for shared info, NET_SKB_PAD, and NET_IP_ALIGN.  With this
> combined with the DMA changes we can start using build_skb to build
> frames around an incoming Rx buffer instead of having to memcpy the
> headers.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   17 ++++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   43
> +++++++++++++++++++++++--
>  2 files changed, 56 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


