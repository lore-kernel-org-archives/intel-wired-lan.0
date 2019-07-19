From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 19 Jul 2019 16:17:41 +0000
Subject: [Intel-wired-lan] [PATCH net] ixgbe: fix possible deadlock in
 ixgbe_service_task()
In-Reply-To: <20190715045706.6140-1-ap420073@gmail.com>
References: <20190715045706.6140-1-ap420073@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40C2DB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Taehee Yoo
> Sent: Sunday, July 14, 2019 9:57 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; ap420073 at gmail.com
> Subject: [Intel-wired-lan] [PATCH net] ixgbe: fix possible deadlock in
> ixgbe_service_task()
> 
> ixgbe_service_task() calls unregister_netdev() under rtnl_lock().
> But unregister_netdev() internally calls rtnl_lock().
> So deadlock would occur.
> 
> Fixes: 59dd45d550c5 ("ixgbe: firmware recovery mode")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
> I did only compile test because I don't have the hardware.
> Could anyone test this patch?
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 --
>  1 file changed, 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


