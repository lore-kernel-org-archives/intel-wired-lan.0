From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Jan 2018 22:28:20 +0000
Subject: [Intel-wired-lan] [PATCH v3 next-queue 02/10] ixgbe: add ipsec
 register access routines
In-Reply-To: <1513728002-7643-3-git-send-email-shannon.nelson@oracle.com>
References: <1513728002-7643-1-git-send-email-shannon.nelson@oracle.com>
 <1513728002-7643-3-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D6DD1@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v3 next-queue 02/10] ixgbe: add ipsec
> register access routines
> 
> Add a few routines to make access to the ipsec registers just a little easier,
> and throw in the beginnings of an initialization.
> 
> v3: fixed a couple checkpatch warnings
> 
> v2: Rx table selector becomes an enum with a shift
>     Combine the clear table loops into one
>     Name the table index shift value
>     Use the addr as __be32
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/Makefile      |   1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h       |   6 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 161
> +++++++++++++++++++++++++
> drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h |  53 ++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |   1 +
>  5 files changed, 222 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


