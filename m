From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 31 Jan 2017 17:34:18 +0000
Subject: [Intel-wired-lan] [next PATCH v2 04/11] ixgbe: Update code to
 better handle incrementing page count
In-Reply-To: <20170117163600.5423.48511.stgit@localhost.localdomain>
References: <20170117163401.5423.37993.stgit@localhost.localdomain>
 <20170117163600.5423.48511.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5D67F@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH v2 04/11] ixgbe: Update code to
> better handle incrementing page count
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> Batch the page count updates instead of doing them one at a time.  By doing
> this we can improve the overall performance as the atomic increment
> operations can be expensive due to the fact that on x86 they are locked
> operations which can cause stalls.  By doing bulk updates we can consolidate
> the stall which should help to improve the overall receive performance.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |    7 ++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   39 ++++++++++++++++--
> -------
>  2 files changed, 31 insertions(+), 15 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


