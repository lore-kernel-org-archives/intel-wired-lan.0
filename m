From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 4 Oct 2018 18:24:32 +0000
Subject: [Intel-wired-lan] [PATCH 04/16] i40e: Replace spin_is_locked()
 with lockdep
In-Reply-To: <20181003053902.6910-5-ldr709@gmail.com>
References: <20181003053902.6910-1-ldr709@gmail.com>
 <20181003053902.6910-5-ldr709@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FD117@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Lance Roy
> Sent: Tuesday, October 2, 2018 10:39 PM
> To: linux-kernel at vger.kernel.org
> Cc: netdev at vger.kernel.org; Lance Roy <ldr709@gmail.com>; intel-wired-
> lan at lists.osuosl.org; Paul E. McKenney <paulmck@linux.ibm.com>; David S.
> Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH 04/16] i40e: Replace spin_is_locked() with
> lockdep
> 
> lockdep_assert_held() is better suited to checking locking requirements,
> since it won't get confused when someone else holds the lock. This is also a
> step towards possibly removing spin_is_locked().
> 
> Signed-off-by: Lance Roy <ldr709@gmail.com>
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: intel-wired-lan at lists.osuosl.org
> Cc: <netdev@vger.kernel.org>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


