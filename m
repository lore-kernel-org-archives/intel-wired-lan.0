From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 May 2020 21:40:15 +0000
Subject: [Intel-wired-lan] [PATCH S45 04/15] ice: Separate VF VSI
 initialization/creation from reset flow
In-Reply-To: <20200516005121.4963-4-anthony.l.nguyen@intel.com>
References: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
 <20200516005121.4963-4-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659920FEA7F1E28F1664D298C8E0@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Friday, May 15, 2020 5:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S45 04/15] ice: Separate VF VSI
> initialization/creation from reset flow
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently the same flow is used for VF VSI initialization/creation and VF VSI
> reset. This makes the initialization/creation flow unnecessarily complicated.
> Fix this by separating the initialization/creation of the VF VSI from the reset
> flow.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 110 +++++++++++++++++-
>  1 file changed, 106 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


