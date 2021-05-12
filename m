From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 12 May 2021 15:42:00 +0000
Subject: [Intel-wired-lan] [PATCH V3 net] ice: Re-organizes reqstd/avail
 {R, T}XQ check/code for efficiency
In-Reply-To: <20210423000018.20244-1-salil.mehta@huawei.com>
References: <20210423000018.20244-1-salil.mehta@huawei.com>
Message-ID: <CO1PR11MB510568A203307FF255D12771FA529@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Salil Mehta
> Sent: Thursday, April 22, 2021 5:00 PM
> To: davem at davemloft.net; kuba at kernel.org
> Cc: salil.mehta at huawei.com; netdev at vger.kernel.org;
> linuxarm at huawei.com; linuxarm at openeuler.org; linux-
> kernel at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH V3 net] ice: Re-organizes reqstd/avail {R,
> T}XQ check/code for efficiency
> 
> If user has explicitly requested the number of {R,T}XQs, then it is
> unnecessary to get the count of already available {R,T}XQs from the PF
> avail_{r,t}xqs bitmap. This value will get overridden by user specified value in
> any case.
> 
> Re-organize this code for improving the flow, readability and efficiency.
> This scope of improvement was found during the review of the ICE driver
> code.
> 
> Fixes: 87324e747fde ("ice: Implement ethtool ops for channels")
> Cc: intel-wired-lan at lists.osuosl.org
> Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
> Change:
> V2->V3
>  (*) Addressed some comments from Paul Menzel
>      Link: https://lkml.org/lkml/2021/4/21/136
> V1->V2
>  (*) Fixed the comments from Anthony Nguyen(Intel)
>      Link: https://lkml.org/lkml/2021/4/12/1997
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)
