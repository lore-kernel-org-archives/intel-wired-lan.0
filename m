From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 31 Jan 2017 17:36:25 +0000
Subject: [Intel-wired-lan] [next PATCH v2 10/11] ixgbe: Add support
	for	build_skb
In-Reply-To: <20170117163709.5423.61819.stgit@localhost.localdomain>
References: <20170117163401.5423.37993.stgit@localhost.localdomain>
 <20170117163709.5423.61819.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5D6DD@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH v2 10/11] ixgbe: Add support for
> build_skb
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch adds build_skb support to the Rx path.  There are several
> advantages to this change.
> 
> 1.  It avoids the memcpy and skb->head allocation for small packets which
>     improves performance by about 5% in my tests.
> 2.  It avoids the memcpy, skb->head allocation, and eth_get_headlen
>     for larger packets improving performance by about 10% in my tests.
> 3.  For VXLAN packets it allows the full header to be in skb->data which
>     improves the performance by as much as 30% in some of my tests.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   49
> ++++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


