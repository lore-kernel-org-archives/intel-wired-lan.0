From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 2 Jul 2019 22:52:18 +0000
Subject: [Intel-wired-lan] [PATCH S22 06/16] ice: Do not configure port
 with no media
In-Reply-To: <20190626092027.52845-6-anthony.l.nguyen@intel.com>
References: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
 <20190626092027.52845-6-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FBE04@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, June 26, 2019 2:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S22 06/16] ice: Do not configure port with
> no media
> 
> The firmware reports an error when trying to configure a port with no media.
> Instead of always configuring the port, check for media before attempting to
> configure it. In the absence of media, turn off link and poll for media to
> become available before re-enabling link.
> 
> Move ice_force_phys_link_state() up to avoid forward declaration.
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h      |   1 +
>  drivers/net/ethernet/intel/ice/ice_main.c | 239 ++++++++++++++--------
>  2 files changed, 158 insertions(+), 82 deletions(-)
>

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



 

