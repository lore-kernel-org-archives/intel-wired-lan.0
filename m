From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Jan 2018 22:30:07 +0000
Subject: [Intel-wired-lan] [PATCH v3 next-queue 05/10] ixgbe: add ipsec
 offload add and remove SA
In-Reply-To: <1513728002-7643-6-git-send-email-shannon.nelson@oracle.com>
References: <1513728002-7643-1-git-send-email-shannon.nelson@oracle.com>
 <1513728002-7643-6-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D6E02@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v3 next-queue 05/10] ixgbe: add ipsec
> offload add and remove SA
> 
> Add the functions for setting up and removing offloaded SAs (Security
> Associations) with the x540 hardware.  We set up the callback structure but
> we don't yet set the hardware feature bit to be sure the XFRM service won't
> actually try to use us for an offload yet.
> 
> The software tables are made up to mimic the hardware tables to make it
> easier to track what's in the hardware, and the SA table index is used for the
> XFRM offload handle.  However, there is a hashing field in the Rx SA tracking
> that will be used to facilitate faster table searches in the Rx fast path.
> 
> v2: fix use of num_rx_sa that should be num_tx_sa
>     change aes_gcm_name to a const array
>     tighten up the key parsing code
>     add another label to the init error handling
>     move table deletion to a separate function
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h       |   2 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 394
> ++++++++++++++++++++++++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |   1 +
>  3 files changed, 396 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


