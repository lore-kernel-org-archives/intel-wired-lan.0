From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Aug 2018 21:09:15 +0000
Subject: [Intel-wired-lan] [PATCH next-queue 5/8] ixgbe: add VF IPsec
 offload request message handling
In-Reply-To: <1534185825-12451-6-git-send-email-shannon.nelson@oracle.com>
References: <1534185825-12451-1-git-send-email-shannon.nelson@oracle.com>
 <1534185825-12451-6-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2E9190@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH next-queue 5/8] ixgbe: add VF IPsec
> offload request message handling
> 
> Add an add and a delete message for IPsec offload requests from the VF.
> These call into the ipsec functions that can translate the message buffer into
> a useful IPsec offload.
> 
> These new messages bump the mbox API version to 1.4.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h       | 19 ++++++++++++++-----
>  drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h   |  5 +++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 17 ++++++++++++++++-
>  3 files changed, 35 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


