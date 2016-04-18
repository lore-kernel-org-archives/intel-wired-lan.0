From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 18 Apr 2016 22:50:52 +0000
Subject: [Intel-wired-lan] [next PATCH S34 10/12] i40e: Drop extra copy
 of	function
In-Reply-To: <1460542112-20166-11-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460542112-20166-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1460542112-20166-11-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2092@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Harshitha Ramamurthy
> Sent: Wednesday, April 13, 2016 3:09 AM
> To: intel-wired-lan at osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S34 10/12] i40e: Drop extra copy of
> function
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> i40e_release_rx_desc was in two files, but was only used and needed in
> txrx.c.  Get rid of the extra copy.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-Id: I86e18239aa03531fc198b6c052847475084a9200
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 18 ------------------
>  1 file changed, 18 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
