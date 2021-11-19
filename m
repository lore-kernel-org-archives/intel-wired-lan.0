From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 19 Nov 2021 13:26:20 +0000
Subject: [Intel-wired-lan] [PATCH] net: ixgbevf: Remove redundant
 initialization of variable ret_val
In-Reply-To: <20210910115100.45429-1-colin.king@canonical.com>
References: <20210910115100.45429-1-colin.king@canonical.com>
Message-ID: <BYAPR11MB3367B7C420AA4FE8F5E41D10FC9C9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Colin
> King
> Sent: Friday, September 10, 2021 5:21 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; David S . Miller <davem@davemloft.net>;
> Jakub Kicinski <kuba@kernel.org>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org
> Cc: kernel-janitors at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] net: ixgbevf: Remove redundant initialization
> of variable ret_val
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable ret_val is being initialized with a value that is never read, it is
> being updated later on. The assignment is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/vf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
