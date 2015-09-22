From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 22 Sep 2015 21:17:35 +0000
Subject: [Intel-wired-lan] [next PATCH S15 12/15] i40e: X722 is on the
 IOSF	bus and does not report the PCI bus info
In-Reply-To: <1441315142-173025-13-git-send-email-catherine.sullivan@intel.com>
References: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
 <1441315142-173025-13-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B16FE@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S15 12/15] i40e: X722 is on the IOSF
> bus and does not report the PCI bus info
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> X722 will report Gen 1x1 in the PCI config space as it is on IOSF bus, so skip
> the PCI bus link/speed check.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: Icd5f5751dc7fb00dccf0d5dc5a0a644948e7062e
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 69
> ++++++++++++++++++++---------
>  2 files changed, 50 insertions(+), 20 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
