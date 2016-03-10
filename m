From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 10 Mar 2016 18:41:35 +0000
Subject: [Intel-wired-lan] [PATCH 3/5] ixgbe/ixgbevf: Add support for
 bulk free in Tx cleanup & cleanup boolean logic
In-Reply-To: <20160307173009.5682.9616.stgit@localhost.localdomain>
References: <20160307172722.5682.38580.stgit@localhost.localdomain>
 <20160307173009.5682.9616.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99CCE7@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, March 07, 2016 9:30 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 3/5] ixgbe/ixgbevf: Add support for bulk
> free in Tx cleanup & cleanup boolean logic
> 
> This patch enables bulk free in Tx cleanup for ixgbevf and cleans up the
> boolean logic in the polling routines for ixgbe and ixgbevf in the hopes of
> avoiding any mix-ups similar to what occurred with i40e and i40evf.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |   10 +++++++---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   14 +++++++++-----
>  2 files changed, 16 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Driver correctly builds and passes traffic normally.
