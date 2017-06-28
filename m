From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Jun 2017 22:22:08 +0000
Subject: [Intel-wired-lan] [next-queue PATCH] i40evf: remove
	unnecessary	__packed
In-Reply-To: <1498151531-18508-1-git-send-email-tushar.n.dave@oracle.com>
References: <1498151531-18508-1-git-send-email-tushar.n.dave@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAC00B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tushar Dave
> Sent: Thursday, June 22, 2017 10:12 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [next-queue PATCH] i40evf: remove unnecessary
> __packed
> 
> This is similar to 'commit 9588397d24eec ("i40e: remove unnecessary
> __packed")' to avoid unaligned access.
> 
> Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40e_osdep.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


