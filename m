From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Oct 2015 20:08:16 +0000
Subject: [Intel-wired-lan] [next PATCH S20 05/15] i40evf: rename vf
 adapter	specific rss function
In-Reply-To: <1445903081-155893-6-git-send-email-catherine.sullivan@intel.com>
References: <1445903081-155893-1-git-send-email-catherine.sullivan@intel.com>
 <1445903081-155893-6-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D47D9@ORSMSX104.amr.corp.intel.com>
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
> Cc: Zhang, Helin
> Subject: [Intel-wired-lan] [next PATCH S20 05/15] i40evf: rename vf adapter
> specific rss function
> 
> From: Helin Zhang <helin.zhang@intel.com>
> 
> This patch renames old VF adapter specific rss function to clarify its scope.
> 
> Signed-off-by: Helin Zhang <helin.zhang@intel.com>
> Change-ID: Ie5253083a44c677ebb7709a8a3a18402ad2dc6a6
> 
> ---
> Testing-hints: Test compile only, no functional change.
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
