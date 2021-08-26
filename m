From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Thu, 26 Aug 2021 03:45:28 +0000
Subject: [Intel-wired-lan] [next-queue v4 02/13] ice: remove dead code
 for allocating pin_config
In-Reply-To: <20210824000158.1928482-3-anthony.l.nguyen@intel.com>
References: <20210824000158.1928482-1-anthony.l.nguyen@intel.com>
 <20210824000158.1928482-3-anthony.l.nguyen@intel.com>
Message-ID: <BYAPR11MB33676C75D3E3BDDF80ABB35EFCC79@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Tuesday, August 24, 2021 5:32 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next-queue v4 02/13] ice: remove dead code for
> allocating pin_config
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> We have code in the ice driver which allocates the pin_config structure if
> n_pins is > 0, but we never set n_pins to be greater than zero.
> There's no reason to keep this code until we actually have pin_config
> support. Remove this. We can re-add it properly when we implement
> support for pin_config for E810-T devices.
> 
> Fixes: 172db5f91d5f ("ice: add support for auxiliary input/output pins")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
