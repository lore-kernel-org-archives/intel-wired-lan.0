From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 5 Aug 2019 21:40:37 +0000
Subject: [Intel-wired-lan] [PATCH S26 13/15] ice: add print of autoneg
 state to link message
In-Reply-To: <20190802082533.23083-13-anthony.l.nguyen@intel.com>
References: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
 <20190802082533.23083-13-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40F125@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, August 2, 2019 1:26 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S26 13/15] ice: add print of autoneg state
> to link message
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Print the state of autonegotiation when printing the Link up message.  Adds
> new text to the "NIC Link is up" line like
> Autoneg: <True | False>
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


