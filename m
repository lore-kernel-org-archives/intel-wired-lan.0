From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 31 Jan 2017 17:32:48 +0000
Subject: [Intel-wired-lan] [next PATCH v2 01/11] ixgbe: Add function for
 checking to see if we can reuse page
In-Reply-To: <20170117163524.5423.68148.stgit@localhost.localdomain>
References: <20170117163401.5423.37993.stgit@localhost.localdomain>
 <20170117163524.5423.68148.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5D654@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH v2 01/11] ixgbe: Add function for
> checking to see if we can reuse page
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch consolidates the code for the ixgbe driver so that it is more inline
> with what is already in igb.  The general idea is to just consolidate functions
> that represent logical steps in the Rx process so we can later update them
> more easily.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> 
> v2: Fix missing rx_ring parameter for PAGE_SIZE > 4K
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   71 +++++++++++++++----
> ------
>  1 file changed, 42 insertions(+), 29 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


