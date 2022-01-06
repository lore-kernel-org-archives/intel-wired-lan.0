From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Thu, 6 Jan 2022 04:47:00 +0000
Subject: [Intel-wired-lan] [PATCH] ice: Slightly simply
 ice_find_free_recp_res_idx
In-Reply-To: <dc5cd04eed7dd3100f5860acaa995efa40ddecc8.1637183999.git.christophe.jaillet@wanadoo.fr>
References: <dc5cd04eed7dd3100f5860acaa995efa40ddecc8.1637183999.git.christophe.jaillet@wanadoo.fr>
Message-ID: <MW3PR11MB4554704CA84792B1E75110E69C4C9@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Christophe JAILLET
>Sent: Thursday, November 18, 2021 2:51 AM
>To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
><anthony.l.nguyen@intel.com>; davem at davemloft.net; kuba at kernel.org
>Cc: netdev at vger.kernel.org; kernel-janitors at vger.kernel.org; Christophe
>JAILLET <christophe.jaillet@wanadoo.fr>; intel-wired-lan at lists.osuosl.org;
>linux-kernel at vger.kernel.org
>Subject: [Intel-wired-lan] [PATCH] ice: Slightly simply
>ice_find_free_recp_res_idx
>
>The 'possible_idx' bitmap is set just after it is zeroed, so we can save the first
>step.
>
>The 'free_idx' bitmap is used only at the end of the function as the result of a
>bitmap xor operation. So there is no need to explicitly zero it before.
>
>So, slightly simply the code and remove 2 useless 'bitmap_zero()' call
>
>Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>---
>I don't think it will make any differences in RL. ICE_MAX_FV_WORDS is just 48
>(bits), so 1 or 2 longs
>---
> drivers/net/ethernet/intel/ice/ice_switch.c | 2 --
> 1 file changed, 2 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
