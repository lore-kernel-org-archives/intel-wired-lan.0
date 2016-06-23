From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jun 2016 15:50:22 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix minor typo while freeing
 irq
In-Reply-To: <1466296847-82299-1-git-send-email-babu.moger@oracle.com>
References: <1466296847-82299-1-git-send-email-babu.moger@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9E8E80@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Babu Moger
> Sent: Saturday, June 18, 2016 5:41 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; Nelson, Shannon
> <shannon.nelson@intel.com>; Wyborny, Carolyn
> <carolyn.wyborny@intel.com>; Skidmore, Donald C
> <donald.c.skidmore@intel.com>; Allan, Bruce W <bruce.w.allan@intel.com>;
> Ronciak, John <john.ronciak@intel.com>; Williams, Mitch A
> <mitch.a.williams@intel.com>; intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; linux-kernel at vger.kernel.org;
> babu.moger at oracle.com
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix minor typo while freeing irq
> 
> The array subscript increments after the execution of the statement.
> So there is no issue here. However it helps to read the code better.
> 
> Signed-off-by: Babu Moger <babu.moger@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
