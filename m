From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 29 Apr 2016 21:38:33 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: fix misleading indentation
In-Reply-To: <1461951855-2038011-1-git-send-email-arnd@arndb.de>
References: <1461951855-2038011-1-git-send-email-arnd@arndb.de>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D53A1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Arnd Bergmann
> Sent: Friday, April 29, 2016 10:44 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; linux-kernel at vger.kernel.org; intel-
> wired-lan at lists.osuosl.org; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] i40e: fix misleading indentation
> 
> Newly added code in i40e_vc_config_promiscuous_mode_msg() is indented
> in a way that gcc rightly complains about:
> 
> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c: In function
> 'i40e_vc_config_promiscuous_mode_msg':
> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:1543:4: error: this 'if'
> clause does not guard... [-Werror=misleading-indentation]
>     if (f->vlan >= 0 && f->vlan <= I40E_MAX_VLANID)
>     ^~
> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:1550:5: note: ...this
> statement, but the latter is misleadingly indented as if it is guarded by the 'if'
>      aq_err = pf->hw.aq.asq_last_status;
> 
> From the context, it looks like the aq_err assignment was meant to be inside
> of the conditional expression, so I'm adding the appropriate curly braces
> now.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 5676a8b9cd9a ("i40e: Add VF promiscuous mode driver support")
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
No warnings at compile
