From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Jul 2020 17:46:10 +0000
Subject: [Intel-wired-lan] [PATCH S50 11/15] ice: Allow all VLANs in
 safe mode
In-Reply-To: <20200713205318.32425-11-anthony.l.nguyen@intel.com>
References: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
 <20200713205318.32425-11-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB214543DD0FF6C8E55FEDD57E8C7F0@BN6PR1101MB2145.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S50 11/15] ice: Allow all VLANs in safe
> mode
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently the PF VSI's context parameters are left in a bad state when going
> into safe mode. This is causing VLAN traffic to not pass. Fix this by configuring
> the PF VSI to allow all VLAN tagged traffic.
> 
> Also, remove redundant comment explaining the safe mode flow in
> ice_probe().
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 59
> ++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


