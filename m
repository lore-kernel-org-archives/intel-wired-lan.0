From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 18 Apr 2018 18:31:10 +0000
Subject: [Intel-wired-lan] [next-queue PATCH 1/1] ixgbe: cleanup sparse
 warnings
In-Reply-To: <1523644117-5126-1-git-send-email-cathy.zhou@oracle.com>
References: <1523644117-5126-1-git-send-email-cathy.zhou@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A968F0B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of cathy.zhou at oracle.com
> Sent: Friday, April 13, 2018 11:29 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [next-queue PATCH 1/1] ixgbe: cleanup sparse
> warnings
> 
> From: Cathy Zhou <cathy.zhou@oracle.COM>
> 
> Sparse complains valid conversions between restricted types, force attribute
> is used to avoid those warnings.
> 
> Signed-off-by: Cathy Zhou <cathy.zhou@oracle.COM>
> Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c  | 13 ++++++-----
> drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |  2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c   |  2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c  | 25 +++++++++++++--------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   | 29 +++++++++++++++----
> ------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_model.h  | 16 +++++++-------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c   |  9 ++++----
>  7 files changed, 55 insertions(+), 41 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


