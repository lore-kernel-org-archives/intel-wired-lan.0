From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 2 Apr 2019 19:24:55 +0000
Subject: [Intel-wired-lan] [PATCH 2/6] igb: mark expected switch
 fall-through
In-Reply-To: <20190329233850.29630-2-jeffrey.t.kirsher@intel.com>
References: <20190329233850.29630-1-jeffrey.t.kirsher@intel.com>
 <20190329233850.29630-2-jeffrey.t.kirsher@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B970236C0@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Friday, March 29, 2019 4:39 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/6] igb: mark expected switch fall-through
> 
> From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> 
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> drivers/net/ethernet/intel/igb/e1000_82575.c: In function
> ?igb_get_invariants_82575?:
> drivers/net/ethernet/intel/igb/e1000_82575.c:636:6: warning: this statement
> may fall through [-Wimplicit-fallthrough=]
>    if (igb_sgmii_uses_mdio_82575(hw)) {
>       ^
> drivers/net/ethernet/intel/igb/e1000_82575.c:642:2: note: here
>   case E1000_CTRL_EXT_LINK_MODE_PCIE_SERDES:
>   ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> Notice that, in this particular case, the code comment is modified
> in accordance with what GCC is expecting to find.
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_82575.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
