From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Apr 2016 21:50:01 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add register wait for slow
 links
In-Reply-To: <20160407174350.39412.3975.stgit@mdrustad-wks.jf.intel.com>
References: <20160407174350.39412.3975.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9CF48D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Thursday, April 07, 2016 10:44 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Add register wait for slow links
> 
> Use a new register to wait for previous register writes to complete before
> issuing a register read. This is needed when slower links are in use.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
> Testing-hints:
> - Test that x550em_a devices operate at lower speeds without complaint
> - Test that x550em_a devices do not suffer throughput loss with fast links
> - Test that X550EM_x, X550 and other devices operate normally
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   21
> +++++++++++++++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    1 +
>  2 files changed, 22 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Devices pass traffic correctly at low and normal speeds
