From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 6 Feb 2018 22:34:30 +0000
Subject: [Intel-wired-lan] [next PATCH S86 V3 2/8] i40e: broadcast
 filters can trigger overflow promiscuous
In-Reply-To: <20180205111121.59468-2-alice.michael@intel.com>
References: <20180205111121.59468-1-alice.michael@intel.com>
 <20180205111121.59468-2-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A949921@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, February 5, 2018 3:11 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S86 V3 2/8] i40e: broadcast filters can
> trigger overflow promiscuous
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> When adding a bunch of VLANs to all the ports on a device, it's possible to
> run out of space for broadcast filters.  The driver should trigger overflow
> promiscuous in this circumstance to prevent traffic from being unexpectedly
> dropped.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


