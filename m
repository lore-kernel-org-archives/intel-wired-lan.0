From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Aug 2018 21:08:40 +0000
Subject: [Intel-wired-lan] [PATCH next-queue 4/8] ixgbe: add VF IPsec
 offload enable flag
In-Reply-To: <1534185825-12451-5-git-send-email-shannon.nelson@oracle.com>
References: <1534185825-12451-1-git-send-email-shannon.nelson@oracle.com>
 <1534185825-12451-5-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2E9180@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH next-queue 4/8] ixgbe: add VF IPsec
> offload enable flag
> 
> Add a private flag to expressly enable support for VF IPsec offload.
> The VF will have to be "trusted" in order to use the hardware offload, but
> because of the general concerns of managing VF access, we want to be sure
> the user specifically is enabling the feature.
> 
> This is likely a candidate for becoming a netdev feature flag.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h         | 1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 9 +++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c   | 3 ++-
>  3 files changed, 12 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


