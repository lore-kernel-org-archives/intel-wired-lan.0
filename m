From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 May 2020 21:44:20 +0000
Subject: [Intel-wired-lan] [PATCH S45 13/15] ice: Fix transmit for all
 software offloaded VLANs
In-Reply-To: <20200516005121.4963-13-anthony.l.nguyen@intel.com>
References: <20200516005121.4963-1-anthony.l.nguyen@intel.com>
 <20200516005121.4963-13-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659C755CC20AF8D106083188C8E0@DM5PR11MB1659.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S45 13/15] ice: Fix transmit for all software
> offloaded VLANs
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently the driver does not recognize when there is an 802.1AD VLAN tag
> right after the dmac/smac (outermost VLAN tag). If any DCB map is applied
> and/or DCB is enabled this is causing the hardware to insert a VLAN 0 tag
> after the 802.1AD VLAN tag that is already in the packet.
> Fix this by preventing VLAN tag 0 from being added when any VLAN is
> already present after dmac/smac (software offloaded) or skb (hardware
> offloaded).
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 28 +++++-------
> drivers/net/ethernet/intel/ice/ice_dcb_lib.h |  2 +-
>  drivers/net/ethernet/intel/ice/ice_txrx.c    | 45 +++++---------------
>  3 files changed, 21 insertions(+), 54 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


