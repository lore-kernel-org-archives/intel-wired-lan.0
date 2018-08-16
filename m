From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Aug 2018 21:09:46 +0000
Subject: [Intel-wired-lan] [PATCH next-queue 6/8] ixgbevf: add defines
 for IPsec offload request
In-Reply-To: <1534185825-12451-7-git-send-email-shannon.nelson@oracle.com>
References: <1534185825-12451-1-git-send-email-shannon.nelson@oracle.com>
 <1534185825-12451-7-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2E91A0@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH next-queue 6/8] ixgbevf: add defines for
> IPsec offload request
> 
> Fix up the register definitions for using IPsec offloads and add the new
> mailbox message IDs.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/defines.h | 8 ++++++++
>  drivers/net/ethernet/intel/ixgbevf/mbx.h     | 5 +++++
>  2 files changed, 13 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


