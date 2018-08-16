From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Aug 2018 21:10:19 +0000
Subject: [Intel-wired-lan] [PATCH next-queue 7/8] ixgbevf: add VF ipsec
 offload code
In-Reply-To: <1534185825-12451-8-git-send-email-shannon.nelson@oracle.com>
References: <1534185825-12451-1-git-send-email-shannon.nelson@oracle.com>
 <1534185825-12451-8-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2E91B0@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH next-queue 7/8] ixgbevf: add VF ipsec
> offload code
> 
> Add the ipsec offload support code.  This is based off of the similar code in
> ixgbe, but instead of writing the SA registers, the VF asks the PF to setup the
> offload by sending the offload information to the PF via the standard
> mailbox.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/Makefile  |   1 +
>  drivers/net/ethernet/intel/ixgbevf/ipsec.c   | 673
> +++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ixgbevf/ipsec.h   |  66 +++
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h |   8 +
>  4 files changed, 748 insertions(+)
>  create mode 100644 drivers/net/ethernet/intel/ixgbevf/ipsec.c
>  create mode 100644 drivers/net/ethernet/intel/ixgbevf/ipsec.h


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


