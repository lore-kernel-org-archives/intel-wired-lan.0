From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Jan 2018 22:32:02 +0000
Subject: [Intel-wired-lan] [PATCH v3 next-queue 08/10] ixgbe: process
 the Tx ipsec offload
In-Reply-To: <1513728002-7643-9-git-send-email-shannon.nelson@oracle.com>
References: <1513728002-7643-1-git-send-email-shannon.nelson@oracle.com>
 <1513728002-7643-9-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D6E31@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v3 next-queue 08/10] ixgbe: process the Tx
> ipsec offload
> 
> If the skb has a security association referenced in the skb, then set up the Tx
> descriptor with the ipsec offload bits.  While we're here, we fix an oddly
> named field in the context descriptor struct.
> 
> v3: added ifdef CONFIG_XFRM_OFFLOAD check around call to
> ixgbe_ipsec_tx()
> 
> v2: use ihl != 5
>     move the ixgbe_ipsec_tx() call to near the call to ixgbe_tso()
>     drop the ipsec packet if the tx offload setup fails
>     simplify the ixgbe_ipsec_tx() parameters by using 'first'
>     leave out the ixgbe_tso() changes since we don't support TSO
>        with ipsec yet.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h       | 10 +++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 79
> ++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c   |  4 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  | 26 +++++++--
> drivers/net/ethernet/intel/ixgbe/ixgbe_type.h  |  2 +-
>  5 files changed, 112 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


