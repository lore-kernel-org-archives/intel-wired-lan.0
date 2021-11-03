From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Wed, 3 Nov 2021 08:55:22 +0000
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix deadlock occurrence
 during resetting VF interface
In-Reply-To: <20210907092540.59568-1-jedrzej.jagielski@intel.com>
References: <20210907092540.59568-1-jedrzej.jagielski@intel.com>
Message-ID: <DM8PR11MB5621CF6907354AC9BCD51915AB8C9@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jedrzej Jagielski
> Sent: wtorek, 7 wrze?nia 2021 11:26
> To: intel-wired-lan at lists.osuosl.org
> Cc: Gawin, JaroslawX <jaroslawx.gawin@intel.com>; Jagielski, Jedrzej
> <jedrzej.jagielski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix deadlock occurrence during
> resetting VF interface
> 
> System hangs if close the interface is called from the kernel during the
> interface is in resetting state.
> During resetting operation the link is closing but kernel didn't know it and it
> tried to close this interface again what sometimes led to deadlock.
> Inform kernel about current state of interface and turn off the flag IFF_UP
> when interface is closing until reset is finished.
> Previously it was most likely to hang the system when kernel (network
> manager) tried to close the interface in the same time when interface was in
> resetting state because of deadlock.
> 
> Fixes: 3c8e0b989aa1 ("i40vf: don't stop me now")
> Signed-off-by: Jaroslaw Gawin <jaroslawx.gawin@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 80437ef26391..a089c0cbc26c 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -2207,6 +2207,7 @@ continue_reset:

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
