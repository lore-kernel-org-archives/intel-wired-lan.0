From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Aug 2018 21:10:49 +0000
Subject: [Intel-wired-lan] [PATCH next-queue 8/8] ixgbevf: enable VF
 ipsec offload operations
In-Reply-To: <1534185825-12451-9-git-send-email-shannon.nelson@oracle.com>
References: <1534185825-12451-1-git-send-email-shannon.nelson@oracle.com>
 <1534185825-12451-9-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2E91BC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Shannon Nelson
> Sent: Monday, August 13, 2018 11:44 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: steffen.klassert at secunet.com; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH next-queue 8/8] ixgbevf: enable VF ipsec
> offload operations
> 
> Add the ipsec initialization into the driver startup and add the Rx and Tx
> processing hooks.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/defines.h      |  2 +-
>  drivers/net/ethernet/intel/ixgbevf/ethtool.c      |  2 +
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      | 25 ++++++++
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 74
> +++++++++++++++++------
>  drivers/net/ethernet/intel/ixgbevf/vf.c           |  4 ++
>  5 files changed, 86 insertions(+), 21 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


