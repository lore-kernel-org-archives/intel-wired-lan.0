From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Thu, 11 Mar 2021 00:33:30 +0000
Subject: [Intel-wired-lan] [PATCH S55 09/14] ice: remove unnecessary
 duplicated AQ command flag setting
In-Reply-To: <20210302181213.51718-9-anthony.l.nguyen@intel.com>
References: <20210302181213.51718-1-anthony.l.nguyen@intel.com>
 <20210302181213.51718-9-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB51056B96BF83C6553AE0F625FA909@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Tuesday, March 2, 2021 10:12 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S55 09/14] ice: remove unnecessary
> duplicated AQ command flag setting
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> Commit a012dca9f7a2 ("ice: add ethtool -m support for reading i2c eeprom
> modules") unnecessarily added the ICE_AQ_FLAG_BUF flag to the descriptor
> when sending the indirect Read/Write SFF EEPROM AQ command. The flag is
> already added later in the code flow for all indirect AQ commands, i.e.
> commands that provide an additional data buffer.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


