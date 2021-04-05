From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Mon, 5 Apr 2021 22:48:24 +0000
Subject: [Intel-wired-lan] [PATCH S57 10/14] ice: Limit forced overrides
 based on FW version
In-Reply-To: <20210325223517.17722-10-anthony.l.nguyen@intel.com>
References: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
 <20210325223517.17722-10-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB5105F2ADC8548FBC8498939CFA779@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, March 25, 2021 3:35 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S57 10/14] ice: Limit forced overrides based
> on FW version
> 
> From: Jeb Cramer <jeb.j.cramer@intel.com>
> 
> Beyond a specific version of firmware, there is no need to provide override
> values to the firmware when setting PHY capabilities.  In this case, we do not
> need to indicate whether we're in Strict or Lenient Link Mode.
> 
> In the case of translating capabilities to the configuration structure, the
> module compliance enforcement is already correctly set by firmware, so the
> extra code block is redundant.
> 
> Signed-off-by: Jeb Cramer <jeb.j.cramer@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


