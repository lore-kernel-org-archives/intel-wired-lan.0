From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 23 Dec 2015 19:51:46 +0000
Subject: [Intel-wired-lan] [next PATCH 1/2] i40e: change log messages
 and	error returns
In-Reply-To: <1450827283-34667-1-git-send-email-mitch.a.williams@intel.com>
References: <1450827283-34667-1-git-send-email-mitch.a.williams@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F96F945@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mitch Williams
> Sent: Tuesday, December 22, 2015 3:35 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 1/2] i40e: change log messages and
> error returns
> 
> When VFs are being reset, there is a brief window of time when they cannot
> be configured because they don't have a VSI to configure. If a script is quick,
> it can fall through that window. To avoid defenestration, log a useful error
> message and return -EAGAIN.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 27 ++++++++++++++---
> -----
>  1 file changed, 18 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, returns error when rapidly creating and destroying VFs in a loop
