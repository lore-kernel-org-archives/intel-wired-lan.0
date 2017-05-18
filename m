From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 May 2017 22:39:00 +0000
Subject: [Intel-wired-lan] [PATCH 3/5] ixgbe: always call setup_mac_link
 for	multispeed fiber
In-Reply-To: <20170517221751.15538.97694.stgit@localhost6.localdomain6>
References: <20170517221424.15538.5968.stgit@localhost6.localdomain6>
 <20170517221751.15538.97694.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA3B12@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Wednesday, May 17, 2017 3:18 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 3/5] ixgbe: always call setup_mac_link for
> multispeed fiber
> 
> Remove the logic which would previously skip the link configuration in the
> case where we are already at the requested speed in
> ixgbe_setup_mac_link_multispeed_fiber().
> 
> By exiting early we are skipping the link configuration and as such the driver
> may not always configure the PHY correctly for SFP+.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |   18 ------------------
>  1 file changed, 18 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


