From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 Apr 2016 23:05:46 +0000
Subject: [Intel-wired-lan] [PATCH next S35 v3 8/9] i40evf: Allocate
	rx	buffers properly
In-Reply-To: <1461004429-34316-9-git-send-email-jesse.brandeburg@intel.com>
References: <1461004429-34316-1-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-2-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-3-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-4-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-5-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-6-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-7-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-8-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-9-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2424@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Monday, April 18, 2016 11:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH next S35 v3 8/9] i40evf: Allocate rx buffers
> properly
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Allocate the correct number of RX buffers, and don't fiddle with
> next_to_use. The common RX code handles all of this. This fixes a memory
> leak of one page each time the driver is opened.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-Id: Id06eca353086e084921f047acad28c14745684ee
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
KEDR leak check doesn't show any leaks when loading and unloading driver
