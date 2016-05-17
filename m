From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 17 May 2016 17:38:36 +0000
Subject: [Intel-wired-lan] [PATCH net] driver:
	ixgbevf:	ixgbevf_write/read_posted_mbx should use
	IXGBE_ERR_MBX to	initialize ret_val
In-Reply-To: <c74ebf3e68d0207e95f71086693916fe99f10658.1463075515.git.lucien.xin@gmail.com>
References: <c74ebf3e68d0207e95f71086693916fe99f10658.1463075515.git.lucien.xin@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D6953@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Xin Long
> Sent: Thursday, May 12, 2016 10:52 AM
> To: network dev <netdev@vger.kernel.org>; intel-wired-lan at lists.osuosl.org
> Cc: davem at davemloft.net
> Subject: [Intel-wired-lan] [PATCH net] driver: ixgbevf:
> ixgbevf_write/read_posted_mbx should use IXGBE_ERR_MBX to initialize
> ret_val
> 
> Now ixgbevf_write/read_posted_mbx use -IXGBE_ERR_MBX as the initiative
> return value, but it's incorrect, cause in ixgbevf_vlan_rx_add_vid(), it use err
> == IXGBE_ERR_MBX, the err returned from mac.ops.set_vfta, and in
> ixgbevf_set_vfta_vf, it return from write/read_posted. so we should
> initialize err with IXGBE_ERR_MBX, instead of -IXGBE_ERR_MBX.
> 
> With this fix, the other functions that called it also can work well, cause they
> only care about if err is 0 or not.
> 
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/mbx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

