From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Thu, 16 Sep 2021 04:57:52 +0000
Subject: [Intel-wired-lan] [next-queue v4 05/13] ice: introduce
 ice_base_incval function
In-Reply-To: <20210824000158.1928482-6-anthony.l.nguyen@intel.com>
References: <20210824000158.1928482-1-anthony.l.nguyen@intel.com>
 <20210824000158.1928482-6-anthony.l.nguyen@intel.com>
Message-ID: <BYAPR11MB33672F135EAC0636EF9654D6FCDC9@BYAPR11MB3367.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [next-queue v4 05/13] ice: introduce
> ice_base_incval function
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> A future change will add additional possible increment values for the
> E822 device support. To handle this, we want to look up the increment value
> to use instead of hard coding it to the nominal value for E810 devices.
> Introduce ice_base_incval as a function to get the best nominal increment
> value to use.
> 
> For now, it just returns the E810 value, but will be refactored in the future to
> look up the value based on the device type and configured clock frequency.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
