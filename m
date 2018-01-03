From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Jan 2018 22:28:51 +0000
Subject: [Intel-wired-lan] [PATCH v3 next-queue 03/10] ixgbe: add ipsec
 engine start and stop routines
In-Reply-To: <1513728002-7643-4-git-send-email-shannon.nelson@oracle.com>
References: <1513728002-7643-1-git-send-email-shannon.nelson@oracle.com>
 <1513728002-7643-4-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D6DE1@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v3 next-queue 03/10] ixgbe: add ipsec
> engine start and stop routines
> 
> Add in the code for running and stopping the hardware ipsec
> encryption/decryption engine.  It is good to keep the engine off when not in
> use in order to save on the power draw.
> 
> v2: add limiter to do-while loop waiting for paths to drain
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 142
> +++++++++++++++++++++++++
>  1 file changed, 142 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


