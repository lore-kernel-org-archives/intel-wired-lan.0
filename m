From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Apr 2016 21:49:10 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Use correct FC setup function
 for	x550em_a
In-Reply-To: <20160408231929.127408.69940.stgit@mdrustad-wks.jf.intel.com>
References: <20160408231929.127408.69940.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9CF47D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Friday, April 08, 2016 4:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Use correct FC setup function for
> x550em_a
> 
> Somehow the wrong fc_setup function was used for x550em_a, so correct
> that. Also set setup_link to NULL as its value is determined later, just like it is
> with X550EM_x.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Device is properly recognized and will pass traffic
