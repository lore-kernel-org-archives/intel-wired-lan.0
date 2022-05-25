From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Wed, 25 May 2022 03:14:29 +0000
Subject: [Intel-wired-lan] [PATCH] ice: Use correct order for the
 parameters of devm_kcalloc()
In-Reply-To: <627df513c3acf65f9aa5f43ca2bf7826a73c0c7b.1653116222.git.christophe.jaillet@wanadoo.fr>
References: <627df513c3acf65f9aa5f43ca2bf7826a73c0c7b.1653116222.git.christophe.jaillet@wanadoo.fr>
Message-ID: <BYAPR11MB3367EA050DB996F600CF46C9FCD69@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Christophe JAILLET
> Sent: Saturday, May 21, 2022 12:27 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>;
> Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
> Paolo Abeni <pabeni@redhat.com>
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>; intel-wired-
> lan at lists.osuosl.org; kernel-janitors at vger.kernel.org; linux-
> kernel at vger.kernel.org; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] ice: Use correct order for the parameters
> of devm_kcalloc()
> 
> We should have 'n', then 'size', not the opposite.
> This is harmless because the 2 values are just multiplied, but having the
> correct order silence a (unpublished yet) smatch warning.
> 
> While at it use '*tun_seg' instead '*seg'. The both variable have the same
> type, so the result is the same, but it lokks more logical.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
