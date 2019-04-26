From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Apr 2019 20:36:57 +0000
Subject: [Intel-wired-lan] [PATCH S18 10/15] ice: Separate if conditions
 for ice_set_features()
In-Reply-To: <20190416172128.27184-11-anirudh.venkataramanan@intel.com>
References: <20190416172128.27184-1-anirudh.venkataramanan@intel.com>
 <20190416172128.27184-11-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39992C@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S18 10/15] ice: Separate if conditions for
> ice_set_features()
> 
> From: Tony Nguyen <anthony.l.nguyen@intel.com>
> 
> Set features can have multiple features turned on|off in a single call.
> Grouping these all in an if/else means after one condition is met, other
> conditions/features will not be evaluated.  Break the if/else statements by
> feature to ensure all features will be handled properly.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


