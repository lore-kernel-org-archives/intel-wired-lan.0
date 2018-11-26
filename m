From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 26 Nov 2018 23:35:49 +0000
Subject: [Intel-wired-lan] [PATCH net] ixgbe: recognize 1000BaseLX SFP
 modules as 1Gbps
In-Reply-To: <20181124205801.67828-1-jelsasser@appneta.com>
References: <20181124205801.67828-1-jelsasser@appneta.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D32ACF0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Josh Elsasser
> Sent: Saturday, November 24, 2018 12:58 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; David S. Miller <davem@davemloft.net>; Josh
> Elsasser <jelsasser@appneta.com>; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net] ixgbe: recognize 1000BaseLX SFP
> modules as 1Gbps
> 
> Add the two 1000BaseLX enum values to the X550's check for 1Gbps
> modules, allowing the core driver code to establish a link over this SFP type.
> 
> This is done by the out-of-tree driver but the fix wasn't in mainline.
> 
> Fixes: 6a14ee0cfb19 ("ixgbe: Add X550 support function pointers")
> Signed-off-by: Josh Elsasser <jelsasser@appneta.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


