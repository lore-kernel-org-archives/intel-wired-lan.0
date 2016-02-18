From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 Feb 2016 23:09:04 +0000
Subject: [Intel-wired-lan] [v2 next PATCH S29 12/14] i40e:
	suspend	scheduling during driver unload
In-Reply-To: <1455815965-9735-2-git-send-email-avinash.dayanand@intel.com>
References: <1455815965-9735-1-git-send-email-avinash.dayanand@intel.com>
 <1455815965-9735-2-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98F360@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Avinash Dayanand
> Sent: Thursday, February 18, 2016 9:19 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [v2 next PATCH S29 12/14] i40e: suspend
> scheduling during driver unload
> 
> From: Pandi Kumar Maharajan <pandi.maharajan@intel.com>
> 
> We need to suspend scheduling or any pending service task during driver
> unload process, so that new task will not be scheduled. This patch sets the
> suspend flag bit during reload which avoids service task execution.
> 
> v2: change patch title
> 
> Signed-off-by: Pandi Kumar Maharajan <pandi.maharajan@intel.com>
> Change-ID: I017c57b5d6656564556e3c5387da671369a572ac
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes properly applied
