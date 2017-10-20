From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 20 Oct 2017 17:58:30 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: enable multicast on shutdown
 for	WOL
In-Reply-To: <20171010202000.32625.17259.stgit@localhost6.localdomain6>
References: <20171010202000.32625.17259.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAD163@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Tuesday, October 10, 2017 1:20 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: enable multicast on shutdown for
> WOL
> 
> Previously we only enabled the reception of multicast packets when wake on
> multicast is set, but we also need this to allow waking with
> IPv6 magic packets.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


