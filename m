From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Wed, 11 Aug 2021 12:51:10 +0000
Subject: [Intel-wired-lan] [PATCH net-next 2/7] ice: Fix link mode
 handling
In-Reply-To: <20210716221644.45946-3-anthony.l.nguyen@intel.com>
References: <20210716221644.45946-1-anthony.l.nguyen@intel.com>
 <20210716221644.45946-3-anthony.l.nguyen@intel.com>
Message-ID: <BL0PR11MB33639C6CEE134C46C60794EEFCF89@BL0PR11MB3363.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Saturday, July 17, 2021 3:47 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next 2/7] ice: Fix link mode handling
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> The messaging for unsupported module detection is different for lenient
> mode and strict mode. Update the code to print the right messaging for a
> given link mode.
> 
> Media topology conflict is not an error in lenient mode, so return an error
> code only if not in lenient mode.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
