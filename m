From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 19 Mar 2018 22:13:22 +0000
Subject: [Intel-wired-lan] [next-queue v2 4/4] ixgbe: enable tso with
 ipsec offload
In-Reply-To: <1521223747-12018-5-git-send-email-shannon.nelson@oracle.com>
References: <1521223747-12018-1-git-send-email-shannon.nelson@oracle.com>
 <1521223747-12018-5-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94CD70@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Shannon Nelson
> Sent: Friday, March 16, 2018 11:09 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: steffen.klassert at secunet.com; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [next-queue v2 4/4] ixgbe: enable tso with ipsec
> offload
> 
> Fix things up to support TSO offload in conjunction with IPsec hw offload.
> This raises throughput with IPsec offload on to nearly line rate.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
> v2 updates from Alex's comments:
>  - changed feature add from variable to #define
>  - fixed a reverse christmas tree miss
>  - GSO_PARTIAL'd the ipv4 header checksum
>  - dropped an extra blank line
> 
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c |  9 +++++++--
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  | 26
> ++++++++++++++++++--------
>  2 files changed, 25 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


