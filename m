From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Thu, 10 Feb 2022 05:29:53 +0000
Subject: [Intel-wired-lan] [PATCH v2] ice: change "can't set link"
 message to dbg level
In-Reply-To: <cfb30f5c84364c8eff96c0a3ea0231e5dfda17e4.1643910316.git.jtoppins@redhat.com>
References: <b25f9e524c404820b310c73012507c8e65a2ef97.1643834329.git.jtoppins@redhat.com>
 <cfb30f5c84364c8eff96c0a3ea0231e5dfda17e4.1643910316.git.jtoppins@redhat.com>
Message-ID: <BYAPR11MB336795B622887929554E63B0FC2F9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jonathan Toppins
> Sent: Thursday, February 3, 2022 11:15 PM
> To: netdev at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org; Jakub Kicinski <kuba@kernel.org>; intel-
> wired-lan at lists.osuosl.org; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH v2] ice: change "can't set link" message to
> dbg level
> 
> In the case where the link is owned by manageability, the firmware is not
> allowed to set the link state, so an error code is returned.
> This however is non-fatal and there is nothing the operator can do, so
> instead of confusing the operator with messages they can do nothing about
> hide this message behind the debug log level.
> 
> Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
