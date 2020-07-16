From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 16 Jul 2020 17:46:28 +0000
Subject: [Intel-wired-lan] [PATCH S50 04/15] ice: restore VF MSI-X state
 during PCI reset
In-Reply-To: <20200713205318.32425-4-anthony.l.nguyen@intel.com>
References: <20200713205318.32425-1-anthony.l.nguyen@intel.com>
 <20200713205318.32425-4-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB2145D228AACB811B27C9D9C38C7F0@BN6PR1101MB2145.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S50 04/15] ice: restore VF MSI-X state
> during PCI reset
> 
> From: Nick Nunley <nicholas.d.nunley@intel.com>
> 
> During a PCI FLR the MSI-X Enable flag in the VF PCI MSI-X capability register
> will be cleared. This can lead to issues when a VF is assigned to a VM because
> in these cases the VF driver receives no indication of the PF PCI error/reset
> and additionally it is incapable of restoring the cleared flag in the hypervisor
> configuration space without fully reinitializing the driver interrupt
> functionality.
> 
> Since the VF driver is unable to easily resolve this condition on its own,
> restore the VF MSI-X flag during the PF PCI reset handling.
> 
> Signed-off-by: Nick Nunley <nicholas.d.nunley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c     |  2 ++
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 30 +++++++++++++++++++
> .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |  2 ++
>  3 files changed, 34 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


