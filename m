From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Fri, 25 Jun 2021 22:41:37 +0000
Subject: [Intel-wired-lan] [PATCH] igb: Avoid memcpy() over-reading of
 ETH_SS_STATS
In-Reply-To: <20210616195319.1231564-1-keescook@chromium.org>
References: <20210616195319.1231564-1-keescook@chromium.org>
Message-ID: <SJ0PR11MB5662F0A8BAFBC724EA8347E6FA069@SJ0PR11MB5662.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Kees Cook
> Sent: Wednesday, June 16, 2021 12:53 PM
> To: netdev at vger.kernel.org
> Cc: Kees Cook <keescook@chromium.org>; linux-kernel at vger.kernel.org;
> linux-hardening at vger.kernel.org; Jakub Kicinski <kuba@kernel.org>; intel-
> wired-lan at lists.osuosl.org; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH] igb: Avoid memcpy() over-reading of
> ETH_SS_STATS
> 
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memcpy(), memmove(), and memset(), avoid
> intentionally reading across neighboring array fields.
> 
> The memcpy() is copying the entire structure, not just the first array.
> Adjust the source argument so the compiler can do appropriate bounds
> checking.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


