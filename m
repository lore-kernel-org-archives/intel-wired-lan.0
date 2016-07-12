From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Jul 2016 17:49:20 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Remove redundant memset
In-Reply-To: <20160623050055.GA15082@amitoj-Inspiron-3542>
References: <20160623050055.GA15082@amitoj-Inspiron-3542>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9EA3B9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Amitoj Kaur Chawla
> Sent: Wednesday, June 22, 2016 10:01 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; Nelson, Shannon
> <shannon.nelson@intel.com>; Wyborny, Carolyn
> <carolyn.wyborny@intel.com>; Skidmore, Donald C
> <donald.c.skidmore@intel.com>; Allan, Bruce W <bruce.w.allan@intel.com>;
> Ronciak, John <john.ronciak@intel.com>; Williams, Mitch A
> <mitch.a.williams@intel.com>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org
> Cc: julia.lawall at lip6.fr
> Subject: [Intel-wired-lan] [PATCH] i40e: Remove redundant memset
> 
> Remove redundant call to memset before a call to memcpy.
> 
> The Coccinelle semantic patch used to make this change is as follows:
> @@
> expression e1,e2,e3,e4;
> @@
> 
> - memset(e1,e2,e3);
>   memcpy(e1,e4,e3);
> 
> Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 1 -
>  1 file changed, 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
