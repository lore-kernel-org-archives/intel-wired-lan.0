From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 15 May 2020 19:40:17 +0000
Subject: [Intel-wired-lan] [PATCH S41 02/15] ice: Don't reset and
 rebuild for Tx timeout on PFC enabled queue
In-Reply-To: <20200508004113.39725-2-anthony.l.nguyen@intel.com>
References: <20200508004113.39725-1-anthony.l.nguyen@intel.com>
 <20200508004113.39725-2-anthony.l.nguyen@intel.com>
Message-ID: <DM5PR11MB1659038E8CFD9E5534040D048CBD0@DM5PR11MB1659.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH S41 02/15] ice: Don't reset and rebuild for
> Tx timeout on PFC enabled queue
> 
> From: Avinash JD <avinash.dayanand@intel.com>
> 
> When there's a Tx timeout for a queue which belongs to a PFC enabled TC,
> then it's not because the queue is hung but because PFC is in action.
> 
> In PFC, peer sends a pause frame for a specified period of time when its
> buffer threshold is exceeded (due to congestion). Netdev on the other hand
> checks if ACK is received within a specified time for a TX packet, if not, it'll
> invoke the tx_timeout routine.
> 
> Signed-off-by: Avinash JD <avinash.dayanand@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 58 ++++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_dcb_lib.h | 23 ++++++++
>  drivers/net/ethernet/intel/ice/ice_main.c    | 10 ++++
>  drivers/net/ethernet/intel/ice/ice_type.h    |  2 +
>  4 files changed, 93 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


