From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Oct 2015 21:28:57 +0000
Subject: [Intel-wired-lan] [next PATCH S20 09/15] i40e: Update
	error	messaging
In-Reply-To: <1445903081-155893-10-git-send-email-catherine.sullivan@intel.com>
References: <1445903081-155893-1-git-send-email-catherine.sullivan@intel.com>
 <1445903081-155893-10-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D485C@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S20 09/15] i40e: Update error
> messaging
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch fixes an issue where adminq init failures always provided a
> message that NVM was newer than expected.  This is not always the case for
> init_adminq failures. Without this patch, if adminq init fails for any reason,
> newer nvm message would be given.  This problem is fixed by adding  a
> check for that specific error condition and a different hopefully helpful
> message otherwise.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Change-ID: Iaeaebee4e398989eae40bb70f943ab66a3a521a5
> 
> ---
> Testing-hints: This was only seen with SOME bricked cards. If you have one
> that happens to work, you will see an erroneous error message that the
> firmware is too new. If you cannot find a card that will reproduce the error, a
> simple compile and check that the code is there is sufficient.
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
