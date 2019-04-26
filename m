From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Apr 2019 20:39:10 +0000
Subject: [Intel-wired-lan] [PATCH S18 14/15] ice: Disable sniffing VF
 traffic on PF
In-Reply-To: <20190416172128.27184-15-anirudh.venkataramanan@intel.com>
References: <20190416172128.27184-1-anirudh.venkataramanan@intel.com>
 <20190416172128.27184-15-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39996B@ORSMSX106.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S18 14/15] ice: Disable sniffing VF traffic on
> PF
> 
> From: Michal Swiatkowski <michal.swiatkowski@intel.com>
> 
> Delete code that add default Tx rule on PF. With this rule PF can see Tx VF
> traffic that should go outside. For traffic from VF to another VF default Tx
> rule on PF doesn't apply because of lower priority than VF mac rule.
> 
> With this change on PF in promisc mode we can see only Rx traffic that
> doesn't match any other rule (mac etc.). We can't see Tx traffic from other
> VSI.
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 24 ++---------------------
>  1 file changed, 2 insertions(+), 22 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


