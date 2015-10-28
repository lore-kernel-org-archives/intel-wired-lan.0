From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Oct 2015 21:36:45 +0000
Subject: [Intel-wired-lan] [next PATCH S20 12/15] i40evf: quoth the
	VF	driver, Nevermore
In-Reply-To: <1445903081-155893-13-git-send-email-catherine.sullivan@intel.com>
References: <1445903081-155893-1-git-send-email-catherine.sullivan@intel.com>
 <1445903081-155893-13-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D488F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, October 26, 2015 4:45 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S20 12/15] i40evf: quoth the VF driver,
> Nevermore
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> If, upon a midnight dreary, the PF returns ERR_PARAM when the VF is
> requesting resources, that's fatal. Either the firmware or NVM is badly, badly
> misconfigured, or this VF has been disabled due to a previous VF driver
> sending a bunch of bogus messages.
> 
> Either way, there is no recovery from this. Don't ponder weak and weary,
> just quit.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I09d9f16cc4ee7fec3b57646a289d33838c1c5bf5
> 
> ---
> Testing-hints: Ensure that the VF driver loads and initializes correctly.
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, i40evf driver loads and initializes correctly
