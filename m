From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Fri, 29 Oct 2021 20:55:46 +0000
Subject: [Intel-wired-lan] [PATCH net 1/4] ice: Remove toggling of
 antispoof for VF trusted promiscuous mode
In-Reply-To: <20210505211800.11908-1-anthony.l.nguyen@intel.com>
References: <20210505211800.11908-1-anthony.l.nguyen@intel.com>
Message-ID: <MN2PR11MB4224CBECF9089150B1CD5E8F82879@MN2PR11MB4224.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Nguyen, Anthony L
> Sent: Wednesday, May 5, 2021 2:18 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net 1/4] ice: Remove toggling of antispoof
> for VF trusted promiscuous mode
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently when a trusted VF enables promiscuous mode spoofchk will be
> disabled. This is wrong and should only be modified from the
> ndo_set_vf_spoofchk callback. Fix this by removing the call to toggle
> spoofchk for trusted VFs.
> 
> Fixes: 01b5e89aab49 ("ice: Add VF promiscuous support")
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c   | 18 ------------------
>  1 file changed, 18 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


