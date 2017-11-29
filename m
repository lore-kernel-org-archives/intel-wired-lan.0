From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Nov 2017 17:04:27 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 06/16] ixgbe: Use
 ring values to test for Tx pending
In-Reply-To: <20171122185646.29785.9424.stgit@localhost.localdomain>
References: <20171122185256.29785.93548.stgit@localhost.localdomain>
 <20171122185646.29785.9424.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAFC6F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Wednesday, November 22, 2017 10:57 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 06/16] ixgbe: Use ring
> values to test for Tx pending
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch simplifies the check for Tx pending traffic and makes it more
> holistic as there being any difference between next_to_use and
> next_to_clean is much more informative than if head and tail are equal, as it
> is possible for us to either not update tail, or not be notified of completed
> work in which case next_to_clean would not be equal to head.
> 
> In addition the simplification makes it so that we don't have to read hardware
> which allows us to drop a number of variables that were previously being
> used in the call.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


