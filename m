From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Jul 2019 17:07:47 +0000
Subject: [Intel-wired-lan] [PATCH S24 v2 01/12] ice: Allow egress
 control packets from PF_VSI
In-Reply-To: <20190729090454.5501-1-anthony.l.nguyen@intel.com>
References: <20190729090454.5501-1-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40E84B@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S24 v2 01/12] ice: Allow egress control
> packets from PF_VSI
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> For control packets (i.e. LLDP packets) to be able to egress from the main VSI,
> a bit has to be set in the TX_descriptor.
> This should only be done for the main VSI and only if the FW LLDP agent is
> disabled.  A bit to allow this also has to be set in the VSI context.
> 
> Add the logic to add the necessary bits in the VSI context for the PF_VSI and
> the TX_descriptors for control packets egressing the PF_VSI.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  |  7 +++++++
> drivers/net/ethernet/intel/ice/ice_txrx.c | 11 ++++++++++-
>  2 files changed, 17 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


