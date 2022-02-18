From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 18 Feb 2022 17:06:07 +0000
Subject: [Intel-wired-lan] [PATCH] ice: initialize local variable 'tlv'
In-Reply-To: <20220214154043.2891024-1-trix@redhat.com>
References: <20220214154043.2891024-1-trix@redhat.com>
Message-ID: <BYAPR11MB3367073E33F1DB82CF044702FC379@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> trix at redhat.com
> Sent: Monday, February 14, 2022 9:11 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; davem at davemloft.net; kuba at kernel.org;
> nathan at kernel.org; ndesaulniers at google.com; Greenwalt, Paul
> <paul.greenwalt@intel.com>; Swanson, Evan <evan.swanson@intel.com>
> Cc: netdev at vger.kernel.org; llvm at lists.linux.dev; intel-wired-
> lan at lists.osuosl.org; linux-kernel at vger.kernel.org; Tom Rix
> <trix@redhat.com>
> Subject: [Intel-wired-lan] [PATCH] ice: initialize local variable 'tlv'
> 
> From: Tom Rix <trix@redhat.com>
> 
> Clang static analysis reports this issues
> ice_common.c:5008:21: warning: The left expression of the compound
>   assignment is an uninitialized value. The computed value will
>   also be garbage
>   ldo->phy_type_low |= ((u64)buf << (i * 16));
>   ~~~~~~~~~~~~~~~~~ ^
> 
> When called from ice_cfg_phy_fec() ldo is the unintialized local
> variable tlv.  So initialize.
> 
> Fixes: ea78ce4dab05 ("ice: add link lenient and default override support")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
