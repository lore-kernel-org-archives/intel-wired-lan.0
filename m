From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 8 Aug 2017 23:20:06 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: declare
	ixgbe_mac_operations	structures as const
In-Reply-To: <1500303678-5403-1-git-send-email-bhumirks@gmail.com>
References: <1500303678-5403-1-git-send-email-bhumirks@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB35C1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Bhumika Goyal
> Sent: Monday, July 17, 2017 8:01 AM
> To: julia.lawall at lip6.fr; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-
> wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org
> Cc: Bhumika Goyal <bhumirks@gmail.com>
> Subject: [Intel-wired-lan] [PATCH] ixgbe: declare ixgbe_mac_operations
> structures as const
> 
> Declare ixgbe_mac_operations structures as const as they are only stored in
> the mac_ops field of ixgbe_info structure. This field is of type const and
> therefore ixgbe_mac_operations structure can be made const too.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


