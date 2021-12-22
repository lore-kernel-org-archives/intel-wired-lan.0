From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Wed, 22 Dec 2021 05:01:08 +0000
Subject: [Intel-wired-lan] [PATCH net v2] i40e: Increase delay to 1 s
 after global EMP reset
In-Reply-To: <20211028135114.202530-1-jedrzej.jagielski@intel.com>
References: <20211028135114.202530-1-jedrzej.jagielski@intel.com>
Message-ID: <BYAPR11MB336728F454B88AE78224EE56FC7D9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jedrzej Jagielski
> Sent: Thursday, October 28, 2021 7:21 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Jagielski, Jedrzej <jedrzej.jagielski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v2] i40e: Increase delay to 1 s after global
> EMP reset
> 
> Recently simplified i40e_rebuild causes that FW sometimes is not ready after
> NVM update, the ping does not return.
> 
> Increase the delay in case of EMP reset.
> Old delay of 300 ms was introduced for specific cards for 710 series.
> Now it works for all the cards and delay was increased.
> 
> Fixes: 1fa51a650e1d ("i40e: Add delay after EMP reset for firmware to
> recover")
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> ---
> V2: Fix commit msg
> ---

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
