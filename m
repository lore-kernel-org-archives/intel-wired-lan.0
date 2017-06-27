From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 27 Jun 2017 19:36:12 +0000
Subject: [Intel-wired-lan] [next PATCH S73-V2 1/9] i40e: Fix for trace
 found	with S4 state
In-Reply-To: <20170620221701.46765-1-jeffrey.t.kirsher@intel.com>
References: <20170620221701.46765-1-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DABE96@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, June 20, 2017 3:17 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S73-V2 1/9] i40e: Fix for trace found
> with S4 state
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch fixes a problem found in systems when entering
> S4 state.  This patch fixes the problem by ensuring that the misc vector's irq is
> disabled as well.  Without this patch a stack trace can be seen upon entering
> S4 state.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


