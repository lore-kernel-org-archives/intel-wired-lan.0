From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 15 May 2020 19:39:44 +0000
Subject: [Intel-wired-lan] [PATCH S41 01/15] ice: Add VF promiscuous
 support
In-Reply-To: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
References: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659BC65988C92D7864DD6128CBD0@DM5PR11MB1659.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, May 7, 2020 5:41 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S41 01/15] ice: Add VF promiscuous
> support
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Implement promiscuous support for VF VSIs. Behaviour of promiscuous
> support is based on VF trust as well as the, introduced, vf-true-promisc flag.
> 
> A trusted VF with vf-true-promisc disabled will be the default VSI, which
> means that all traffic without a matching destination MAC address in the
> device's internal switch will be forwarded to this VF VSI.
> 
> A trusted VF with vf-true-promisc enabled will go into "true promiscuous
> mode". This amounts to the VF receiving all ingress and egress traffic that hits
> the device's internal switch.
> 
> An untrusted VF will only receive traffic destined for that VF.
> 
> The vf-true-promisc-support flag cannot be toggled while any VF is in
> promiscuous mode. This flag should be set prior to loading the iavf driver or
> spawning VF(s).
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |   1 +
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  12 +
> .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 206 +++++++++++++++++-
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.h  |   6 +
>  4 files changed, 223 insertions(+), 2 deletions(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


