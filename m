From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 25 Oct 2017 19:42:50 +0000
Subject: [Intel-wired-lan] [jkirsher/net-queue PATCH] ixgbe: Fix Tx
	map	failure path
In-Reply-To: <20171019210700.14788.7976.stgit@ahduyck-green-test.jf.intel.com>
References: <20171019210700.14788.7976.stgit@ahduyck-green-test.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAD60D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Thursday, October 19, 2017 2:07 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [jkirsher/net-queue PATCH] ixgbe: Fix Tx map
> failure path
> 
> This patch is a partial revert of "ixgbe: Don't bother clearing buffer memory
> for descriptor rings". Specifically I messed up the exception handling path a
> bit and this resulted in us incorrectly adding the count back in when we didn't
> need to.
> 
> In order to make this simpler I am reverting most of the exception handling
> path change and instead just replacing the bit that was handled by the
> unmap_and_free call.
> 
> Fixes: ffed21bcee7a ("ixgbe: Don't bother clearing buffer memory for
> descriptor rings")
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


