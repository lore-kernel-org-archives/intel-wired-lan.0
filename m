From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 24 May 2016 16:07:06 +0000
Subject: [Intel-wired-lan] [PATCH 1/1] net: i40e: avoid null
	pointer	dereference
In-Reply-To: <1463517693-10333-1-git-send-email-xypron.glpk@gmx.de>
References: <1463517693-10333-1-git-send-email-xypron.glpk@gmx.de>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D7053@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Heinrich Schuchardt
> Sent: Tuesday, May 17, 2016 1:42 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org; Heinrich Schuchardt <xypron.glpk@gmx.de>
> Subject: [Intel-wired-lan] [PATCH 1/1] net: i40e: avoid null pointer
> dereference
> 
> In function i40e_debug_aq parameter desc is assumed to be possibly NULL.
> Do not dereference it before checking the value.
> 
> Fixes: f905dd62be88 ("i40e/i40evf: add max buf len to aq debug print
> helper")
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
