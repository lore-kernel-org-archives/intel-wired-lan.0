From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 12 May 2021 15:48:37 +0000
Subject: [Intel-wired-lan] [PATCH S59 02/13] ice: add extack when unable
 to read device caps
In-Reply-To: <20210506154008.12880-2-anthony.l.nguyen@intel.com>
References: <20210506154008.12880-1-anthony.l.nguyen@intel.com>
 <20210506154008.12880-2-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB510586114AEA5F488EDA9A1AFA529@CO1PR11MB5105.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S59 02/13] ice: add extack when unable to
> read device caps
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> When filling out information for the DEVLINK_CMD_INFO_GET, the driver
> needs to read some device capabilities. Add an extack message to properly
> inform the caller of the failure, as we do for other failures in this function.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_devlink.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


