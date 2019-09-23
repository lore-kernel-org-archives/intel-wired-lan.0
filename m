From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 23 Sep 2019 18:12:09 +0000
Subject: [Intel-wired-lan] [next PATCH S10 06/10] i40e: remove the macro
 with it's argument reuse
In-Reply-To: <20190920091724.51767-6-alice.michael@intel.com>
References: <20190920091724.51767-1-alice.michael@intel.com>
 <20190920091724.51767-6-alice.michael@intel.com>
Message-ID: <dc5a32c1a739447588a0208fdb45ab83@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, September 20, 2019 2:17 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S10 06/10] i40e: remove the macro
> with it's argument reuse
> 
> From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> 
> Remove macro and call i40e_update_vfid_in_stats() function directly to
> avoid checkpatch.pl complains about macro argument reuse and possible
> side effects.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    | 28 ++++---------------
>  1 file changed, 6 insertions(+), 22 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


