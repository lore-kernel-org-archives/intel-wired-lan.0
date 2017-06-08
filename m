From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 8 Jun 2017 18:28:50 +0000
Subject: [Intel-wired-lan] [next PATCH S72-V3 04/13] i40e: comment
	that	udp_port must be in host byte order
In-Reply-To: <20170607094313.32060-4-alice.michael@intel.com>
References: <20170607094313.32060-1-alice.michael@intel.com>
 <20170607094313.32060-4-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAA8DF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, June 7, 2017 2:43 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S72-V3 04/13] i40e: comment that
> udp_port must be in host byte order
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The firmware expects the port number passed when setting up the UDP
> tunnel configuration to be in Little Endian format.
> The i40e_aq_add_udp_tunnel command byte swaps the value from host
> order to Little Endian.
> 
> Since commit fe0b0cd97b4f ("i40e: send correct port number to AdminQ
> when enabling UDP tunnels") we've correctly sent the value in host order.
> 
> Let's also add a comment to the function explaining that it must be in host
> order, as the port numbers are commonly stored as Big Endian values.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


