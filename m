From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 6 Apr 2016 16:37:36 +0000
Subject: [Intel-wired-lan] [PATCH V5 04/11] ixgbe: Use new methods for
 PHY	access
In-Reply-To: <20160401191814.120975.37572.stgit@mdrustad-wks.jf.intel.com>
References: <20160401191701.120975.34684.stgit@mdrustad-wks.jf.intel.com>
 <20160401191814.120975.37572.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9ACEEA@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Friday, April 01, 2016 12:18 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH V5 04/11] ixgbe: Use new methods for PHY
> access
> 
> Now x550em_a devices will use a new method for PHY access that will get
> the firmware token for each access.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
> Changes in V4:
> - This is a complete replacement of what was the 4th patch in the series
> - x550em_a requires a new phy access method, so this patch implements it
> Changes in V5:
> - Delete trailing space from a comment
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   67
> ++++++++++++++++++++++++-
>  1 file changed, 64 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch applied and compiles cleanly, hardware passes traffic
