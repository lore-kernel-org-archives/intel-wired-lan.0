From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 4 Jun 2020 19:10:44 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: make PF wait reset loop reliable
In-Reply-To: <20200526105112.3228-1-piotr.kwapulinski@intel.com>
References: <20200526105112.3228-1-piotr.kwapulinski@intel.com>
Message-ID: <MWHPR11MB1663313E11F84AE525DAC1B18C890@MWHPR11MB1663.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Piotr Kwapulinski
> Sent: Tuesday, May 26, 2020 3:51 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
> Subject: [Intel-wired-lan] [PATCH] i40e: make PF wait reset loop reliable
> 
> Use jiffies to limit max waiting time for PF reset to succeed.
> Previous wait loop was unreliable. It required unreasonably long time to wait
> for PF reset after reboot when NIC was about to enter recovery mode
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


