From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 13 Oct 2018 00:11:37 +0000
Subject: [Intel-wired-lan] [PATCH 05/16] igbvf: Replace spin_is_locked()
 with lockdep
In-Reply-To: <20181003053902.6910-6-ldr709@gmail.com>
References: <20181003053902.6910-1-ldr709@gmail.com>
 <20181003053902.6910-6-ldr709@gmail.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9657ABF9@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org [mailto:netdev-
> owner at vger.kernel.org] On Behalf Of Lance Roy
> Sent: Tuesday, October 2, 2018 10:39 PM
> To: linux-kernel at vger.kernel.org
> Cc: Paul E. McKenney <paulmck@linux.ibm.com>; Lance Roy
> <ldr709@gmail.com>; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David
> S. Miller <davem@davemloft.net>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org
> Subject: [PATCH 05/16] igbvf: Replace spin_is_locked() with lockdep
> 
> lockdep_assert_held() is better suited to checking locking requirements,
> since it won't get confused when someone else holds the lock. This is
> also a step towards possibly removing spin_is_locked().
> 
> Signed-off-by: Lance Roy <ldr709@gmail.com>
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: intel-wired-lan at lists.osuosl.org
> Cc: <netdev@vger.kernel.org>
> ---
>  drivers/net/ethernet/intel/igbvf/mbx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

