From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 19 Jul 2019 16:21:27 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: reduce stack usage in
 i40e_set_fc
In-Reply-To: <20190715123518.3510791-1-arnd@arndb.de>
References: <20190715123518.3510791-1-arnd@arndb.de>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40C2EB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Arnd Bergmann
> Sent: Monday, July 15, 2019 5:35 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S. Miller
> <davem@davemloft.net>
> Cc: Catherine Sullivan <catherine.sullivan@intel.com>; Dziggel, Douglas A
> <douglas.a.dziggel@intel.com>; Arnd Bergmann <arnd@arndb.de>;
> netdev at vger.kernel.org; Patryk Ma?ek <patryk.malek@intel.com>; linux-
> kernel at vger.kernel.org; Azarewicz, Piotr <piotr.azarewicz@intel.com>;
> Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; clang-built-
> linux at googlegroups.com; intel-wired-lan at lists.osuosl.org; Marczak, Piotr
> <piotr.marczak@intel.com>
> Subject: [Intel-wired-lan] [PATCH] i40e: reduce stack usage in i40e_set_fc
> 
> The functions i40e_aq_get_phy_abilities_resp() and i40e_set_fc() both have
> giant structure on the stack, which makes each one use stack frames larger
> than 500 bytes.
> 
> As clang decides one function into the other, we get a warning for exceeding
> the frame size limit on 32-bit architectures:
> 
> drivers/net/ethernet/intel/i40e/i40e_common.c:1654:23: error: stack frame
> size of 1116 bytes in function 'i40e_set_fc' [-Werror,-Wframe-larger-than=]
> 
> When building with gcc, the inlining does not happen, but i40e_set_fc() calls
> i40e_aq_get_phy_abilities_resp() anyway, so they add up on the kernel
> stack just as much.
> 
> The parts that actually use large stacks don't overlap, so make sure each one
> is a separate function, and mark them as noinline_for_stack to prevent the
> compilers from combining them again.
> 
> Fixes: 0a862b43acc6 ("i40e/i40evf: Add module_types and
> update_link_info")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 91 +++++++++++--------
>  1 file changed, 51 insertions(+), 40 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



