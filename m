From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 29 Aug 2016 17:29:36 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Resolve NULL reference by
 setting {read, write}_reg_mdi
In-Reply-To: <147224810802.93893.10477874136622778687.stgit@mdrustad-wks.jf.intel.com>
References: <147224810802.93893.10477874136622778687.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FAF29@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Friday, August 26, 2016 2:48 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Resolve NULL reference by setting
> {read, write}_reg_mdi
> 
> Set the read_reg_mdi and write_reg_mdi method pointers for
> X550EM_A_10G_T devices to resolve jumping to NULL.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    2 ++
>  1 file changed, 2 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


