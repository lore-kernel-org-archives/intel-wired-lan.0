From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 3 Nov 2016 15:53:29 +0000
Subject: [Intel-wired-lan] [PATCH net-next] i40evf: Move
	some	i40evf_reset_task code to separate function
In-Reply-To: <a93a0a56a25a4f5357e548af6e535f4d5e06ea74.1478039638.git.joe@perches.com>
References: <a93a0a56a25a4f5357e548af6e535f4d5e06ea74.1478039638.git.joe@perches.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA29FCF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joe Perches
> Sent: Tuesday, November 01, 2016 3:35 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next] i40evf: Move some
> i40evf_reset_task code to separate function
> 
> The i40evf_reset_task function is a couple hundred lines and it has a
> separable block that disables vf.  Move that block to a new i40evf_disable_vf
> function to shorten i40evf_reset_task a bit.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 86 +++++++++++++-------
> -----
>  1 file changed, 44 insertions(+), 42 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


