From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Wed, 16 Mar 2022 06:14:24 +0000
Subject: [Intel-wired-lan] [PATCH] igb: zero hwtstamp by default
In-Reply-To: <20220313150210.1508203-1-trix@redhat.com>
References: <20220313150210.1508203-1-trix@redhat.com>
Message-ID: <BYAPR11MB3367BC9F34175A1D52EB68D4FC119@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> trix at redhat.com
> Sent: Sunday, March 13, 2022 8:32 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; davem at davemloft.net; kuba at kernel.org;
> nathan at kernel.org; ndesaulniers at google.com
> Cc: netdev at vger.kernel.org; llvm at lists.linux.dev; intel-wired-
> lan at lists.osuosl.org; linux-kernel at vger.kernel.org; Tom Rix
> <trix@redhat.com>
> Subject: [Intel-wired-lan] [PATCH] igb: zero hwtstamp by default
> 
> From: Tom Rix <trix@redhat.com>
> 
> Clang static analysis reports this representative issue
> igb_ptp.c:997:3: warning: The left operand of '+' is a
>   garbage value
>   ktime_add_ns(shhwtstamps.hwtstamp, adjust);
>   ^            ~~~~~~~~~~~~~~~~~~~~
> 
> shhwtstamps.hwtstamp is set by a call to igb_ptp_systim_to_hwtstamp().  In
> the switch-statement for the hw type, the hwtstamp is zeroed for matches
> but not the default case.  Move the memset out of switch-statement.  This
> degarbages the default case and reduces the size.
> 
> Some whitespace cleanup of empty lines
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_ptp.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
