From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 2 Feb 2018 22:28:42 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Avoid to write the RETA table
 when unnecessary.
In-Reply-To: <1517140417-26439-1-git-send-email-xiangxia.m.yue@gmail.com>
References: <1517140417-26439-1-git-send-email-xiangxia.m.yue@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A9494CC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tonghao Zhang
> Sent: Sunday, January 28, 2018 3:54 AM
> To: intel-wired-lan at osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Avoid to write the RETA table when
> unnecessary.
> 
> If indir == 0 in the ixgbe_set_rxfh(), it is unnecessary to write the HW.
> Because redirection table is not changed.
> 
> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


