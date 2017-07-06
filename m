From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 6 Jul 2017 22:18:46 +0000
Subject: [Intel-wired-lan] [PATCH net] ixgbe: fix masking of bits read
 from	IXGBE_VXLANCTRL register
In-Reply-To: <fc6577fcc305742e61ea24c6eb519c212717e5ec.1499078414.git.sd@queasysnail.net>
References: <fc6577fcc305742e61ea24c6eb519c212717e5ec.1499078414.git.sd@queasysnail.net>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB13F9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sabrina Dubroca
> Sent: Monday, July 3, 2017 4:03 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; Sabrina Dubroca <sd@queasysnail.net>
> Subject: [Intel-wired-lan] [PATCH net] ixgbe: fix masking of bits read from
> IXGBE_VXLANCTRL register
> 
> In ixgbe_clear_udp_tunnel_port(), we read the IXGBE_VXLANCTRL register
> and then try to mask some bits out of the value, using the logical instead of
> bitwise and operator.
> 
> Fixes: a21d0822ff69 ("ixgbe: add support for geneve Rx offload")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


