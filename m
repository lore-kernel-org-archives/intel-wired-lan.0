From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 6 Aug 2021 06:21:18 +0000
Subject: [Intel-wired-lan] [PATCH net] ice: Prevent probing virtual
 functions
In-Reply-To: <20210728193910.644656-1-anirudh.venkataramanan@intel.com>
References: <20210728193910.644656-1-anirudh.venkataramanan@intel.com>
Message-ID: <BYAPR11MB3367B5404EC9C3C9708E7E93FCF39@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Anirudh Venkataramanan
> Sent: Thursday, July 29, 2021 1:09 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net] ice: Prevent probing virtual functions
> 
> The userspace utility "driverctl" can be used to change/override the system's
> default driver choices. This is useful in some situations (buggy driver, old
> driver missing a device ID, trying a workaround,
> etc.) where the user needs to load a different driver.
> 
> However, this is also prone to user error, where a driver is mapped to a
> device it's not designed to drive. For example, if the ice driver is mapped to
> driver iavf devices, the ice driver crashes.
> 
> Add a check to return an error if the ice driver is being used to probe a virtual
> function.
> 
> Fixes: 837f08fdecbe ("ice: Add basic driver framework for Intel(R) E800
> Series")
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
