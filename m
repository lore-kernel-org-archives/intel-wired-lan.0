From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 2 Feb 2022 10:32:17 +0000
Subject: [Intel-wired-lan] [PATCH] ethernet/intel: remove redundant ret
 variable
In-Reply-To: <20220110104656.646861-1-chi.minghao@zte.com.cn>
References: <20220110104656.646861-1-chi.minghao@zte.com.cn>
Message-ID: <DM8PR11MB5621F1AA3A53025D348243C9AB279@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> cgel.zte at gmail.com
> Sent: Monday, January 10, 2022 11:47 AM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>
> Cc: netdev at vger.kernel.org; Zeal Robot <zealci@zte.com.cn>; linux-
> kernel at vger.kernel.org; Minghao Chi <chi.minghao@zte.com.cn>; intel-
> wired-lan at lists.osuosl.org; CGEL ZTE <cgel.zte@gmail.com>;
> kuba at kernel.org; davem at davemloft.net
> Subject: [Intel-wired-lan] [PATCH] ethernet/intel: remove redundant ret
> variable
> 
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value directly instead of taking this in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 504fea4e90fb..a138dc64b8b7 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
