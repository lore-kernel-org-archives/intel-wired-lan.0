From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 8 Apr 2021 19:44:08 +0000
Subject: [Intel-wired-lan] [PATCH][next] ice: Fix potential infinite
 loop when using u8 loop counter
In-Reply-To: <20210331144628.1423252-1-colin.king@canonical.com>
References: <20210331144628.1423252-1-colin.king@canonical.com>
Message-ID: <CO1PR11MB51053F26FD4F24B78969B0F3FA749@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Colin King
> Sent: Wednesday, March 31, 2021 7:46 AM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; David S . Miller <davem@davemloft.net>;
> Jakub Kicinski <kuba@kernel.org>; Cao, Chinh T <chinh.t.cao@intel.com>;
> intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org
> Cc: kernel-janitors at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH][next] ice: Fix potential infinite loop when
> using u8 loop counter
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> A for-loop is using a u8 loop counter that is being compared to a u32
> cmp_dcbcfg->numapp to check for the end of the loop. If cmp_dcbcfg-
> >numapp is larger than 255 then the counter j will wrap around to zero and
> hence an infinite loop occurs. Fix this by making counter j the same type as
> cmp_dcbcfg->numapp.
> 
> Addresses-Coverity: ("Infinite loop")
> Fixes: aeac8ce864d9 ("ice: Recognize 860 as iSCSI port in CEE mode")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


