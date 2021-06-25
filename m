From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Fri, 25 Jun 2021 22:34:59 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2] igb: Add counter to i21x
 doublecheck
In-Reply-To: <1619786490-418369-1-git-send-email-grzegorz.siwik@intel.com>
References: <1619786490-418369-1-git-send-email-grzegorz.siwik@intel.com>
Message-ID: <SJ0PR11MB5662C4715123F11F95DA69F4FA069@SJ0PR11MB5662.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Grzegorz Siwik
> Sent: Friday, April 30, 2021 5:42 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Siwik, Grzegorz <grzegorz.siwik@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v2] igb: Add counter to i21x
> doublecheck
> 
> Add failed_counter to i21x_doublecheck(). There is possibility that loop will
> never end.
> With this patch the loop will stop after maximum 3 retries to write to
> MTA_REGISTER
> 
> Signed-off-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
> ---
> v2: Changed retries counting method
> Moved hw_dbg info
> ---
>  drivers/net/ethernet/intel/igb/e1000_mac.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


