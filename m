From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 31 Jan 2017 17:34:40 +0000
Subject: [Intel-wired-lan] [next PATCH v2 05/11] ixgbe: Make use of
 order 1 pages and 3K buffers independent of FCoE
In-Reply-To: <20170117163609.5423.56603.stgit@localhost.localdomain>
References: <20170117163401.5423.37993.stgit@localhost.localdomain>
 <20170117163609.5423.56603.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5D68F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, January 17, 2017 8:36 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH v2 05/11] ixgbe: Make use of order 1
> pages and 3K buffers independent of FCoE
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> In order to support build_skb with jumbo frames it will be necessary to use
> 3K buffers for the Rx path with 8K pages backing them.  This is needed on
> architectures that implement 4K pages because we can't support 2K buffers
> plus padding in a 4K page.
> 
> In the case of systems that support page sizes larger than 4K the 3K attribute
> will only be applied to FCoE as we can fall back to using just 2K buffers and
> adding the padding.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   20 +++++++++-----------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   19 +++++++++++++------
>  2 files changed, 22 insertions(+), 17 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


