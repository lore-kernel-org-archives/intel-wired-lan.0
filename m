From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Jul 2020 17:48:20 +0000
Subject: [Intel-wired-lan] [PATCH S50 12/15] ice: cleanup VSI on probe
 fail
In-Reply-To: <20200713205318.32425-12-anthony.l.nguyen@intel.com>
References: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
 <20200713205318.32425-12-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB21458DEE0F3B08583566CA448C7F0@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Monday, July 13, 2020 1:53 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S50 12/15] ice: cleanup VSI on probe fail
> 
> From: Marcin Szycik <marcin.szycik@intel.com>
> 
> As part of ice_setup_pf_sw() a PF VSI is setup; release the VSI in case of
> failure.
> 
> Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


