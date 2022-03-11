From: Sreenivas, Bharathi <bharathi.sreenivas@intel.com>
Date: Fri, 11 Mar 2022 05:33:20 +0000
Subject: [Intel-wired-lan] [PATCH net v1] ice: destroy flow director
 filter mutex after releasing VSIs
In-Reply-To: <20220310184652.1596373-1-sudheer.mogilappagari@intel.com>
References: <20220310184652.1596373-1-sudheer.mogilappagari@intel.com>
Message-ID: <MN2PR11MB3614B8A69A58316D808100918E0C9@MN2PR11MB3614.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sudheer Mogilappagari
> Sent: Friday, March 11, 2022 12:17 AM
> To: intel-wired-lan at osuosl.org
> Subject: [Intel-wired-lan] [PATCH net v1] ice: destroy flow director filter
> mutex after releasing VSIs
> 
> Currently fdir_fltr_lock is accessed in ice_vsi_release_all() function after it is
> destroyed. Instead destroy mutex after ice_vsi_release_all.
> 
> Fixes: 40319796b732 ("ice: Add flow director support for channel mode")
> Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Tested-by: Bharathi Sreenivas <bharathi.sreenivas@intel.com>
