From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 11 Sep 2015 16:14:22 +0000
Subject: [Intel-wired-lan] [next PATCH S15 09/15] i40e: remove FD
	atr	control from debugfs
In-Reply-To: <1441315142-173025-10-git-send-email-catherine.sullivan@intel.com>
References: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
 <1441315142-173025-10-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A6407@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, September 03, 2015 2:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S15 09/15] i40e: remove FD atr control
> from debugfs
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Since the flow-director-atr priv flag was added to our ethtool interface, we
> don't need the on/off control in debugfs.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: Ib3b599916434ab30ccd40074e71d7a81609b5bb5
> ---
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 24 ------------------------
>  1 file changed, 24 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
