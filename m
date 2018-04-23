From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 23 Apr 2018 20:57:35 +0000
Subject: [Intel-wired-lan] [next PATCH S90 5/8] i40e: Fix multiple
 issues with UDP tunnel offload filter configuration
In-Reply-To: <20180420084140.8081-5-alice.michael@intel.com>
References: <20180420084140.8081-1-alice.michael@intel.com>
 <20180420084140.8081-5-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A976978@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, April 20, 2018 1:42 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S90 5/8] i40e: Fix multiple issues with
> UDP tunnel offload filter configuration
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This fixes at least 2 issues I have found with the UDP tunnel filter
> configuration.
> 
> The first issue is the fact that the tunnels didn't have any sort of mutual
> exlcusion in place to prevent an update from racing with a user request to
> add/remove a port. As such you could request to add and remove a port
> before the port update code had a chance to respond which would result in a
> very confusing result. To address it I have added 2 changes. First I added the
> RTNL mutex wrapper around our updating of the pending, port, and
> filter_index bits. Second I added logic so that we cannot use a port that has a
> pending deletion since we need to free the space in hardware before we can
> allow software to reuse it.
> 
> The second issue addressed is the fact that we were not recording the actual
> filter index provided to us by the admin queue. As a result we were deleting
> filters that were not associated with the actual filter we wanted to delete. To
> fix that I added a filter_index member to the UDP port tracking structure.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  2 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 66
> +++++++++++++++++++++++------
>  2 files changed, 56 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


