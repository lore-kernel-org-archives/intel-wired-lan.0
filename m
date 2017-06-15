From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 15 Jun 2017 23:41:15 +0000
Subject: [Intel-wired-lan] [PATCH 3/5] ixgbe: Update NW_MNG_IF_SEL
 support	for X553
In-Reply-To: <20170607213621.18256-3-anthony.l.nguyen@intel.com>
References: <20170607213621.18256-1-anthony.l.nguyen@intel.com>
 <20170607213621.18256-3-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAB295@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, June 7, 2017 2:36 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 3/5] ixgbe: Update NW_MNG_IF_SEL
> support for X553
> 
> The MAC register NW_MNG_IF_SEL fields have been redefined for X553.
> These changes impact the iXFI driver code flow. Since iXFI is only supported
> in X552, add MAC checks for iXFI flows.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  2 +-
> drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  4 ++--
> drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 14 +++++++++++---
>  3 files changed, 14 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


