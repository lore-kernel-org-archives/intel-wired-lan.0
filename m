From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 19 Mar 2018 18:43:01 +0000
Subject: [Intel-wired-lan] [next-queue PATCH] i40evf: Reorder
 configure_clsflower to avoid deadlock on error
In-Reply-To: <20180314024552.7086.86874.stgit@localhost.localdomain>
References: <20180314024552.7086.86874.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94C950@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, March 13, 2018 7:46 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next-queue PATCH] i40evf: Reorder
> configure_clsflower to avoid deadlock on error
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> While doing some code review I noticed that we can get into a state where
> we exit with the "IN_CRITICAL_TASK" bit set while notifying the PF of flower
> filters. This patch is meant to address that plus tweak the ordering of the
> while loop waiting on it slightly so that we don't wait an extra period after we
> have failed for the last time.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c |   23 +++++++++++---------
> ---
>  1 file changed, 11 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


