From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 10 Jan 2018 00:08:30 +0000
Subject: [Intel-wired-lan] [PATCH next-queue 2/2] ixgbe: add unlikely
 notes to tx fastpath expressions
In-Reply-To: <1515451669-927-2-git-send-email-shannon.nelson@oracle.com>
References: <1515451669-927-1-git-send-email-shannon.nelson@oracle.com>
 <1515451669-927-2-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D8031@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Shannon Nelson
> Sent: Monday, January 8, 2018 2:48 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: steffen.klassert at secunet.com; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH next-queue 2/2] ixgbe: add unlikely notes
> to tx fastpath expressions
> 
> Add unlikely() to a few error checking expressions in the Tx offload handling.
> 
> Suggested-by: Yanjun Zhu <yanjun.zhu@oracle.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


