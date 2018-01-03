From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Jan 2018 22:29:31 +0000
Subject: [Intel-wired-lan] [PATCH v3 next-queue 04/10] ixgbe: add ipsec
 data structures
In-Reply-To: <1513728002-7643-5-git-send-email-shannon.nelson@oracle.com>
References: <1513728002-7643-1-git-send-email-shannon.nelson@oracle.com>
 <1513728002-7643-5-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D6DF1@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v3 next-queue 04/10] ixgbe: add ipsec data
> structures
> 
> Set up the data structures to be used by the ipsec offload.
> 
> v2: ipaddr[] becomes __be32
>     increase the hash table size
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h       |  5 ++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h | 40
> ++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


