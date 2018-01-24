From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 24 Jan 2018 23:37:48 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH] i40e: Fix the
 number of queues available to be mapped for use
In-Reply-To: <151669742383.55162.13181985807500442895.stgit@anamdev.jf.intel.com>
References: <151669742383.55162.13181985807500442895.stgit@anamdev.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A93A305@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Amritha Nambiar
> Sent: Tuesday, January 23, 2018 12:50 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH] i40e: Fix the number
> of queues available to be mapped for use
> 
> Fix the number of queues per enabled TC and report available queues to the
> kernel without having to limit them to the max rss limit so they are available
> to be mapped for XPS. This allows a queue per processing thread available
> for handling traffic for the given traffic class.
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c |   27 ++++++++++++++---------
> ----
>  1 file changed, 14 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


