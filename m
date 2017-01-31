From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 31 Jan 2017 19:28:37 +0000
Subject: [Intel-wired-lan] [next PATCH S58-V3 3/4] i40e: KISS the
	client	interface
In-Reply-To: <1485282241-3579-3-git-send-email-bimmy.pujari@intel.com>
References: <1485282241-3579-1-git-send-email-bimmy.pujari@intel.com>
 <1485282241-3579-3-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5D770@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, January 24, 2017 10:24 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S58-V3 3/4] i40e: KISS the client
> interface
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> (KISS is Keep It Simple, Stupid. Or is it?)
> 
> The client interface vastly overengineered for what it needs to do.
> It was originally designed to support multiple clients on multiple netdevs,
> possibly even with multiple drivers. None of this happened, and now we
> know that there will only ever be one client for i40e
> (i40iw) and one for i40evf (i40iwvf). So, time for some KISS. Since i40e and
> i40evf are a Dynasty, we'll simplify this one to match the VF interface.
> 
> First, be a Destroyer and remove all of the lists and locks required to support
> multiple clients. Keep one static around to keep track of one client, and track
> the client instances for each netdev in the driver's pf (or adapter) struct. Now
> it's Almost Human.
> 
> Since we already know the client type is iWarp, get rid of any checks for this.
> Same for VSI type - it's always going to be the same type, so it's just a
> Parasite.
> 
> While we're at it, fix up some comments. This makes the function headers
> actually match the functions.
> 
> These changes reduce code complexity, simplify maintenance, squash some
> lurking timing bugs, and allow us to Rock and Roll All Nite.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I1ea79948ad73b8685272451440a34507f9a9012e
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             |   8 +-
>  drivers/net/ethernet/intel/i40e/i40e_client.c      | 457 +++++++--------------
>  drivers/net/ethernet/intel/i40e/i40e_client.h      |   8 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c        |  32 +-
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   2 +-
>  5 files changed, 179 insertions(+), 328 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


