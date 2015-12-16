From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Dec 2015 18:37:08 +0000
Subject: [Intel-wired-lan] [next PATCH S23 03/13] i40e:
	Add	mac_filter_element at the end of the list instead of HEAD
In-Reply-To: <1449705033-4968-4-git-send-email-joshua.a.hay@intel.com>
References: <1449705033-4968-1-git-send-email-joshua.a.hay@intel.com>
 <1449705033-4968-4-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F96EF6B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Wednesday, December 09, 2015 3:50 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S23 03/13] i40e: Add
> mac_filter_element at the end of the list instead of HEAD
> 
> From: Kiran Patil <kiran.patil@intel.com>
> 
> Add MAC filter element to the end of the list in the given order, just to be
> tidy, and just in case there are ever any ordering issues in the future.
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Change-ID: Idc15276147593ea9393ac72c861f9c7905a791b4
> ---
> Testing Hints: There is no straight targeted test for this issue.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
