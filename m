From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Oct 2015 21:34:02 +0000
Subject: [Intel-wired-lan] [next PATCH S20 11/15] i40e: make error
 message	more useful
In-Reply-To: <1445903081-155893-12-git-send-email-catherine.sullivan@intel.com>
References: <1445903081-155893-1-git-send-email-catherine.sullivan@intel.com>
 <1445903081-155893-12-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D487F@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S20 11/15] i40e: make error message
> more useful
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> If we get an invalid message from a VF, we should tell the user which VF is
> being naughty, rather than making them guess.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I9252cef7baea3d8584043ed6ff12619a94e2f99c
> 
> ---
> Testing-hints: It is difficult to reproduce the error so just make sure it
> compiles.
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
