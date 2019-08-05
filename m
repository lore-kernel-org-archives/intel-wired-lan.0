From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 5 Aug 2019 21:42:36 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: Explicitly initialize
 reference count to 0
In-Reply-To: <20190802105457.16596-1-hslester96@gmail.com>
References: <20190802105457.16596-1-hslester96@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40F162@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Chuhong Yuan
> Sent: Friday, August 2, 2019 3:55 AM
> Cc: netdev at vger.kernel.org; Chuhong Yuan <hslester96@gmail.com>; linux-
> kernel at vger.kernel.org; intel-wired-lan at lists.osuosl.org; David S . Miller
> <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: Explicitly initialize reference
> count to 0
> 
> The driver does not explicitly call atomic_set to initialize refcount to 0.
> Add the call so that it will be more straight forward to convert refcount from
> atomic_t to refcount_t.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


