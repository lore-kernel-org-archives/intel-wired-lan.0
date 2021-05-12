From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 12 May 2021 22:01:51 +0000
Subject: [Intel-wired-lan] [PATCH S59 10/13] ice: mark PTYPE 2 as
 reserved
In-Reply-To: <20210506154008.12880-10-anthony.l.nguyen@intel.com>
References: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
 <20210506154008.12880-10-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB51059EC2292E3D16D6C2D49DFA529@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, May 6, 2021 8:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S59 10/13] ice: mark PTYPE 2 as reserved
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The entry for PTYPE 2 in the ice_ptype_lkup table incorrectly states that this
> is an L2 packet with no payload. According to the datasheet, this PTYPE is
> actually unused and reserved.
> 
> Fix the lookup entry to indicate this is an unused entry that is reserved.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


