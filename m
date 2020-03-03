From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 3 Mar 2020 19:07:05 +0000
Subject: [Intel-wired-lan] [PATCH S40 08/15] ice: renegotiate link after
 FW DCB on
In-Reply-To: <20200227181505.61720-8-anthony.l.nguyen@intel.com>
References: <20200227181505.61720-1-anthony.l.nguyen@intel.com>
 <20200227181505.61720-8-anthony.l.nguyen@intel.com>
Message-ID: <b458db1d21ea43529731bd6ea0fa718c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 27, 2020 10:15 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S40 08/15] ice: renegotiate link after FW
> DCB on
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> When switching from SW DCB to FW DCB it is necessary to renegotiate DCBx
> so that the FW agent can have up to date information about the DCB settings
> of the link partner.
> 
> Perform an autoneg restart on the link when activating FW DCB.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 53 +++++++++++---------
>  1 file changed, 29 insertions(+), 24 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


