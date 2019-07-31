From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Jul 2019 17:13:41 +0000
Subject: [Intel-wired-lan] [PATCH S24 v2 12/12] ice: Add input handlers
 for virtual channel handlers
In-Reply-To: <20190729090454.5501-12-anthony.l.nguyen@intel.com>
References: <20190729090454.5501-1-anthony.l.nguyen@intel.com>
 <20190729090454.5501-12-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40E8FD@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Monday, July 29, 2019 2:05 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S24 v2 12/12] ice: Add input handlers for
> virtual channel handlers
> 
> From: "Amruth G.P" <amruth.gouda.parameshwarappa@intel.com>
> 
> Move the assignment to local variables after validation.
> 
> Remove unnecessary checks in ice_vc_process_vf_msg() as the respective
> functions are now performing the checks.
> 
> Signed-off-by: Amruth G.P <amruth.gouda.parameshwarappa@intel.com>
> Signed-off-by: Nitesh B Venkatesh <nitesh.b.venkatesh@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> v2: Move Tx|Rx queue check from ice_vc_get_stats_msg() to
> ice_vc_ena_qs_msg()
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 64 +++++++++----------
>  1 file changed, 32 insertions(+), 32 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


