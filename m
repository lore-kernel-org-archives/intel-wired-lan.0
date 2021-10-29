From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Fri, 29 Oct 2021 20:57:46 +0000
Subject: [Intel-wired-lan] [PATCH S59 08/13] ice: Fix replacing VF
 hardware MAC to existing MAC filter
In-Reply-To: <20210506154008.12880-8-anthony.l.nguyen@intel.com>
References: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
 <20210506154008.12880-8-anthony.l.nguyen@intel.com>
Message-ID: <MN2PR11MB4224C14DC87457CAF89B2F7F82879@MN2PR11MB4224.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Nguyen, Anthony L
> Sent: Thursday, May 6, 2021 8:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S59 08/13] ice: Fix replacing VF hardware
> MAC to existing MAC filter
> 
> From: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> 
> VF was not able to change its hardware MAC address in case the new
> address was already present in the MAC filter list.
> Change the handling of VF add mac request to not return if requested MAC
> address is already present on the list and check if its hardware MAC needs to
> be updated in this case.
> 
> Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


