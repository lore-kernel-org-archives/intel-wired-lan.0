From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Wed, 5 Jan 2022 17:27:50 +0000
Subject: [Intel-wired-lan] [PATCH] ice: Use bitmap_free() to free bitmap
In-Reply-To: <d139eb69eb12c9793a2a3b65e94f74d4cee2a39c.1640529439.git.christophe.jaillet@wanadoo.fr>
References: <d139eb69eb12c9793a2a3b65e94f74d4cee2a39c.1640529439.git.christophe.jaillet@wanadoo.fr>
Message-ID: <BYAPR11MB3367AB75CD4C3E312F7CF4A7FC4B9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Christophe JAILLET
> Sent: Sunday, December 26, 2021 8:09 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; davem at davemloft.net; kuba at kernel.org
> Cc: netdev at vger.kernel.org; kernel-janitors at vger.kernel.org; Christophe
> JAILLET <christophe.jaillet@wanadoo.fr>; intel-wired-lan at lists.osuosl.org;
> linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] ice: Use bitmap_free() to free bitmap
> 
> kfree() and bitmap_free() are the same. But using the latter is more consistent
> when freeing memory allocated with bitmap_zalloc().
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
