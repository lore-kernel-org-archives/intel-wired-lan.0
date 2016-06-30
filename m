From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 30 Jun 2016 18:09:01 +0000
Subject: [Intel-wired-lan] [next PTACH S38-v2 6/7] i40e: refactor rx
 filter	handling
In-Reply-To: <1466439039-16378-7-git-send-email-bimmy.pujari@intel.com>
References: <1466439039-16378-1-git-send-email-bimmy.pujari@intel.com>
 <1466439039-16378-7-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9E989D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, June 20, 2016 9:11 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PTACH S38-v2 6/7] i40e: refactor rx filter
> handling
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Properly track filter adds and deletes so the driver doesn't lose filters during
> resets and up/down cycles. Add a tracking mechanism so that the driver
> knows when to enter and leave promiscuous mode.
> 
> Implement a simple state machine so the driver can track the status of each
> filter throughout its lifecycle. Properly manage the overflow promiscuous
> state for the each VSI, and provide a way for the driver to detect when to
> exit overflow promiscuous mode.
> 
> Remove all possible default MAC filters that the firmware may have set up so
> that the driver can manage these correctly, particularly when VLANs come
> into play. Remove the LAA flag for filters; instead just send whatever we get
> through set_mac to the firmware as the LAA for wakeup purposes.
> 
> Finally, add the state of each filter to debugfs output so we can see what's
> going on inside the driver's pointy little head.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I97c5e366fac2254fa01eaff4f65c0af61dcf2e1f
> ---
> Testing Hints : Add many filters (at least 2000). See the device go into
> promiscuous mode. Remove all of these filters and watch the device come
> back from promiscuous mode. Do resets during all stages of this process and
> make sure the filter state is consistent throughout using debugfs.
> 
>  drivers/net/ethernet/intel/i40e/i40e.h         |  14 +-
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c |  16 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 512 ++++++++++++----------
> ---
>  3 files changed, 262 insertions(+), 280 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Functions as expected
