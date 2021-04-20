From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 20 Apr 2021 20:25:53 +0000
Subject: [Intel-wired-lan] [PATCH V2 net] ice: Re-organizes reqstd/avail
 {R, T}XQ check/code for efficiency+readability
In-Reply-To: <20210413224446.16612-1-salil.mehta@huawei.com>
References: <20210413224446.16612-1-salil.mehta@huawei.com>
Message-ID: <CO1PR11MB51058003106492F6552DB98FFA489@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Salil Mehta
> Sent: Tuesday, April 13, 2021 3:45 PM
> To: davem at davemloft.net; kuba at kernel.org
> Cc: salil.mehta at huawei.com; linuxarm at openeuler.org;
> netdev at vger.kernel.org; linuxarm at huawei.com; linux-
> kernel at vger.kernel.org; Jeff Kirsher <jeffrey.t.kirsher@intel.com>; intel-
> wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH V2 net] ice: Re-organizes reqstd/avail {R,
> T}XQ check/code for efficiency+readability
> 
> If user has explicitly requested the number of {R,T}XQs, then it is
> unnecessary to get the count of already available {R,T}XQs from the PF
> avail_{r,t}xqs bitmap. This value will get overridden by user specified value in
> any case.
> 
> This patch does minor re-organization of the code for improving the flow and
> readabiltiy. This scope of improvement was found during the review of the
> ICE driver code.
> 
> FYI, I could not test this change due to unavailability of the hardware.
> It would be helpful if somebody can test this patch and provide Tested-by
> Tag. Many thanks!
> 
> Fixes: 87324e747fde ("ice: Implement ethtool ops for channels")
> Cc: intel-wired-lan at lists.osuosl.org
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> --
> Change V1->V2
>  (*) Fixed the comments from Anthony Nguyen(Intel)
>      Link: https://lkml.org/lkml/2021/4/12/1997
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


