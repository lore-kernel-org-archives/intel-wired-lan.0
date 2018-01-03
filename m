From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Jan 2018 22:33:07 +0000
Subject: [Intel-wired-lan] [PATCH v3 next-queue 10/10] ixgbe: register
 ipsec offload with the xfrm subsystem
In-Reply-To: <1513728002-7643-11-git-send-email-shannon.nelson@oracle.com>
References: <1513728002-7643-1-git-send-email-shannon.nelson@oracle.com>
 <1513728002-7643-11-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D6E51@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v3 next-queue 10/10] ixgbe: register ipsec
> offload with the xfrm subsystem
> 
> With all the support code in place we can now link in the ipsec offload
> operations and set the ESP feature flag for the XFRM subsystem to see.
> 
> v3: added ifdef CONFIG_XFRM_OFFLOAD in ixgbe_features_check
> 
> v2: added the xdo_dev_state_free callback to make XFRM happy
>     changed use of NETIF_F_HW_CSUM_BIT to NETIF_F_HW_CSUM
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 17 +++++++++++++++++
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  6 ++++++
>  2 files changed, 23 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


