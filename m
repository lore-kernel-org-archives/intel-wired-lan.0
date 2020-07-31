From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 31 Jul 2020 20:00:17 +0000
Subject: [Intel-wired-lan] [PATCH S51 07/13] ice: Allow 2 queue pairs
 per VF on SR-IOV initialization
In-Reply-To: <20200730001922.52568-7-anthony.l.nguyen@intel.com>
References: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
 <20200730001922.52568-7-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB21458E51FAA33675234B0DEF8C4E0@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Wednesday, July 29, 2020 5:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S51 07/13] ice: Allow 2 queue pairs per VF
> on SR-IOV initialization
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently VFs are only allowed to get 16, 4, and 1 queue pair by default,
> which require 17, 5, and 2 MSI-X vectors respectively. This is because each VF
> needs a MSI-X per data queue and a MSI-X for its other interrupt. The
> calculation is based on the number of VFs created, MSI-X available, and
> queue pairs available at the time of VF creation.
> 
> Unfortunately the values above exclude 2 queue pairs when only 3 MSI-X are
> available to each VF based on resource constraints. The current calculation
> would default to 2 MSI-X and 1 queue pair. This is a waste of resources, so fix
> this by allowing 2 queue pairs per VF when there are between 2 and 5 MSI-X
> available per VF.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 2 ++
> drivers/net/ethernet/intel/ice/ice_virtchnl_pf.h | 1 +
>  2 files changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


