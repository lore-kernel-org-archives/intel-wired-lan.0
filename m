From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 12 May 2021 22:01:01 +0000
Subject: [Intel-wired-lan] [PATCH S59 09/13] ice: fix incorrect payload
 indicator on PTYPE
In-Reply-To: <20210506154008.12880-9-anthony.l.nguyen@intel.com>
References: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
 <20210506154008.12880-9-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB51050732386CC658FB907ED0FA529@CO1PR11MB5105.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S59 09/13] ice: fix incorrect payload
> indicator on PTYPE
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The entry for PTYPE 90 indicates that the payload is layer 3. This does not
> match the specification in the datasheet which indicates the packet is a MAC,
> IPv6, UDP packet, with a payload in layer 4.
> 
> Fix the lookup table to match the data sheet.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lan_tx_rx.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


