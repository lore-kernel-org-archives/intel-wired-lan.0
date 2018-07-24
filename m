From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 24 Jul 2018 17:26:11 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Remove duplicated prepare call
 in i40e_shutdown
In-Reply-To: <20180719112522.GA16521@gklab-81-211.igk.intel.com>
References: <20180719112522.GA16521@gklab-81-211.igk.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2DA5CB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sergey Nemov
> Sent: Thursday, July 19, 2018 4:25 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] i40e: Remove duplicated prepare call in
> i40e_shutdown
> 
> Function call to i40e_prep_for_reset() is duplicated in i40e_shutdown
> routine and gets called before
> i40e_enable_mc_magic_wake() which blocks it from being executed
> correctly on system reboot or shutdown because adminq is already disabled
> by first i40e_prep_for_reset() call.
> 
> Two register write calls are also duplicated.
> 
> Signed-off-by: Sergey Nemov <sergey.nemov@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 6 ------
>  1 file changed, 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


