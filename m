From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Jan 2018 22:30:43 +0000
Subject: [Intel-wired-lan] [PATCH v3 next-queue 06/10] ixgbe: restore
 offloaded SAs after a reset
In-Reply-To: <1513728002-7643-7-git-send-email-shannon.nelson@oracle.com>
References: <1513728002-7643-1-git-send-email-shannon.nelson@oracle.com>
 <1513728002-7643-7-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D6E11@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Shannon Nelson
> Sent: Tuesday, December 19, 2017 4:00 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: steffen.klassert at secunet.com; sowmini.varadhan at oracle.com;
> netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH v3 next-queue 06/10] ixgbe: restore
> offloaded SAs after a reset
> 
> On a chip reset most of the table contents are lost, so must be restored.  This
> scans the driver's ipsec tables and restores both the filled and empty table
> slots to their pre-reset values.
> 
> v2: during restore, clean the tables before restarting
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h       |  2 ++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 41
> ++++++++++++++++++++++++++
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  1 +
>  3 files changed, 44 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


