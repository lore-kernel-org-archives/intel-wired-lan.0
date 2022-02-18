From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 18 Feb 2022 18:01:51 +0000
Subject: [Intel-wired-lan] [PATCH] ice: check the return of
 ice_ptp_gettimex64
In-Reply-To: <20220214143327.2884183-1-trix@redhat.com>
References: <20220214143327.2884183-1-trix@redhat.com>
Message-ID: <BYAPR11MB336703B0319EADCC0EC3AEC6FC379@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> trix at redhat.com
> Sent: Monday, February 14, 2022 8:03 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; davem at davemloft.net; kuba at kernel.org;
> nathan at kernel.org; ndesaulniers at google.com; Keller, Jacob E
> <jacob.e.keller@intel.com>
> Cc: netdev at vger.kernel.org; llvm at lists.linux.dev; intel-wired-
> lan at lists.osuosl.org; linux-kernel at vger.kernel.org; Tom Rix
> <trix@redhat.com>
> Subject: [Intel-wired-lan] [PATCH] ice: check the return of
> ice_ptp_gettimex64
> 
> From: Tom Rix <trix@redhat.com>
> 
> Clang static analysis reports this issue
> time64.h:69:50: warning: The left operand of '+'
>   is a garbage value
>   set_normalized_timespec64(&ts_delta, lhs.tv_sec + rhs.tv_sec,
>                                        ~~~~~~~~~~ ^ In ice_ptp_adjtime_nonatomic(), the
> timespec64 variable 'now'
> is set by ice_ptp_gettimex64().  This function can fail with -EBUSY, so 'now'
> can have a gargbage value.
> So check the return.
> 
> Fixes: 06c16d89d2cb ("ice: register 1588 PTP clock device object for E810
> devices")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
