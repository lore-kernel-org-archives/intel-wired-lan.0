From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Jan 2018 22:31:21 +0000
Subject: [Intel-wired-lan] [PATCH v3 next-queue 07/10] ixgbe: process
 the Rx ipsec offload
In-Reply-To: <1513728002-7643-8-git-send-email-shannon.nelson@oracle.com>
References: <1513728002-7643-1-git-send-email-shannon.nelson@oracle.com>
 <1513728002-7643-8-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D6E21@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v3 next-queue 07/10] ixgbe: process the Rx
> ipsec offload
> 
> If the chip sees and decrypts an ipsec offload, set up the skb sp pointer with
> the ralated SA info.  Since the chip is rude enough to keep to itself the table
> index it used for the decryption, we have to do our own table lookup, using
> the hash for speed.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h       |  6 ++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 89
> ++++++++++++++++++++++++++
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  3 +
>  3 files changed, 98 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



