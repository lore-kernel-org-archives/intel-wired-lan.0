From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Wed, 5 Jan 2022 17:28:47 +0000
Subject: [Intel-wired-lan] [PATCH] ice: Optimize a few bitmap operations
In-Reply-To: <b0cf67c12895e40b403a435192d47b0ac1a00def.1640250120.git.christophe.jaillet@wanadoo.fr>
References: <b0cf67c12895e40b403a435192d47b0ac1a00def.1640250120.git.christophe.jaillet@wanadoo.fr>
Message-ID: <BYAPR11MB33679085DC82B376235F8885FC4B9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Christophe JAILLET
> Sent: Thursday, December 23, 2021 2:34 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; davem at davemloft.net; kuba at kernel.org
> Cc: netdev at vger.kernel.org; kernel-janitors at vger.kernel.org; Christophe
> JAILLET <christophe.jaillet@wanadoo.fr>; intel-wired-lan at lists.osuosl.org;
> linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] ice: Optimize a few bitmap operations
> 
> When a bitmap is local to a function, it is safe to use the non-atomic
> __[set|clear]_bit(). No concurrent accesses can occur.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
