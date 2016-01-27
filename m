From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 27 Jan 2016 21:04:54 +0000
Subject: [Intel-wired-lan] [next PATCH S23 06/13 v3] i40e/i40evf:
 tunnels	can be generic
In-Reply-To: <1453420954-23011-1-git-send-email-jesse.brandeburg@intel.com>
References: <1453420954-23011-1-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98C930@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Thursday, January 21, 2016 4:03 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S23 06/13 v3] i40e/i40evf: tunnels can
> be generic
> 
> Since the i40e driver now supports VxLAN, GRE, and soon to be Geneve
> tunnels, the driver can just note that an skb contains a tunneled packet
> generically, instead of calling out VXLAN specifically.  The tunnel set up we do
> for hardware is almost always the same for all tunnel types.
> 
> This specifically enables ATR/Flow Director on GRE packets which increases
> performance/scaling.  Without this patch GRE RX packets end up on a
> random RSS assigned queue.
> 
> Reported-by: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: Ie8e205603654910d2f718592cbef8132ae0719e4
> 
> ---
> Testing Hints:
> Test tunnelled traffic, specifically also test VxLAN and other tunnel types to
> make sure that ATR counters are still counting when doing IPv4/TCP traffic
> over the tunnel.
> 
> ---
> v2: Fix code error found by Alex, by repairing if/else clause
>     for tunnel.
> 
> v3: remove extra parens
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 13 +++++++------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  2 +-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |  2 +-
> drivers/net/ethernet/intel/i40evf/i40e_txrx.h |  2 +-
>  4 files changed, 10 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Tunnel traffic properly increments ATR counters with IPv4 and IPv6 traffic over IPv4 and IPv6 tunnels
