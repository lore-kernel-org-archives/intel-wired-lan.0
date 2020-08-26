From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 26 Aug 2020 23:48:05 +0000
Subject: [Intel-wired-lan] [PATCH v3] ice: remove repeated words
In-Reply-To: <20200818214900.35776-1-anthony.l.nguyen@intel.com>
References: <20200818214900.35776-1-anthony.l.nguyen@intel.com>
Message-ID: <DM6PR11MB2890BEE1E4C99C6EAD674F0ABC540@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Tony
> Nguyen
> Sent: Tuesday, August 18, 2020 2:49 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3] ice: remove repeated words
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> A new test in checkpatch detects repeated words; cleanup all pre-existing
> occurrences of those now.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Co-developed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> v3:
> - Resolve checkpatch warning on ordering of Co-developed-by and Signed-off-
> by
> v2:
> - Add Co-developed-by
> ---
>  drivers/net/ethernet/intel/ice/ice_flex_pipe.c   | 2 +-
>  drivers/net/ethernet/intel/ice/ice_flow.c        | 4 ++--
>  drivers/net/ethernet/intel/ice/ice_main.c        | 2 +-
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
