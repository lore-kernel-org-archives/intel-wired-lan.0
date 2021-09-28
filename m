From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Tue, 28 Sep 2021 04:03:02 +0000
Subject: [Intel-wired-lan] [PATCH v7] ixgbe: let the xdpdrv work with
 more than 64 cpus
In-Reply-To: <20210901101206.50274-1-kerneljasonxing@gmail.com>
References: <20210901101206.50274-1-kerneljasonxing@gmail.com>
Message-ID: <MW3PR11MB455445ABC2EE8E063D72AEF89CA89@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>kerneljasonxing at gmail.com
>Sent: Wednesday, September 1, 2021 3:42 PM
>To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
><anthony.l.nguyen@intel.com>; davem at davemloft.net; kuba at kernel.org;
>ast at kernel.org; daniel at iogearbox.net; hawk at kernel.org;
>john.fastabend at gmail.com; andrii at kernel.org; kafai at fb.com;
>songliubraving at fb.com; yhs at fb.com; kpsingh at kernel.org
>Cc: Shujin Li <lishujin@kuaishou.com>; Jason Xing
><xingwanli@kuaishou.com>; kerneljasonxing at gmail.com;
>netdev at vger.kernel.org; linux-kernel at vger.kernel.org; intel-wired-
>lan at lists.osuosl.org; bpf at vger.kernel.org
>Subject: [Intel-wired-lan] [PATCH v7] ixgbe: let the xdpdrv work with more
>than 64 cpus
>
>From: Jason Xing <xingwanli@kuaishou.com>
>
>Originally, ixgbe driver doesn't allow the mounting of xdpdrv if the server is
>equipped with more than 64 cpus online. So it turns out that the loading of
>xdpdrv causes the "NOMEM" failure.
>
>Actually, we can adjust the algorithm and then make it work through mapping
>the current cpu to some xdp ring with the protect of @tx_lock.
>
>Here're some numbers before/after applying this patch with xdp-example
>loaded on the eth0X:
>
>As client (tx path):
>                     Before    After
>TCP_STREAM send-64   734.14    714.20
>TCP_STREAM send-128  1401.91   1395.05
>TCP_STREAM send-512  5311.67   5292.84
>TCP_STREAM send-1k   9277.40   9356.22 (not stable)
>TCP_RR     send-1    22559.75  21844.22
>TCP_RR     send-128  23169.54  22725.13
>TCP_RR     send-512  21670.91  21412.56
>
>As server (rx path):
>                     Before    After
>TCP_STREAM send-64   1416.49   1383.12
>TCP_STREAM send-128  3141.49   3055.50
>TCP_STREAM send-512  9488.73   9487.44
>TCP_STREAM send-1k   9491.17   9356.22 (not stable)
>TCP_RR     send-1    23617.74  23601.60
>...
>
>Notice: the TCP_RR mode is unstable as the official document explaines.
>
>I tested many times with different parameters combined through netperf.
>Though the result is not that accurate, I cannot see much influence on this
>patch. The static key is places on the hot path, but it actually shouldn't cause a
>huge regression theoretically.
>
>Fixes: 33fdc82f08 ("ixgbe: add support for XDP_TX action")
>Reported-by: kernel test robot <lkp@intel.com>
>Co-developed-by: Shujin Li <lishujin@kuaishou.com>
>Signed-off-by: Shujin Li <lishujin@kuaishou.com>
>Signed-off-by: Jason Xing <xingwanli@kuaishou.com>
>---
>v7:
>- Factorized to a single spin_lock/unlock in ixgbe_xdp_xmit() (Eric)
>- Handle other parts of lock/unlock in ixgbe_run_xdp()/_zc() (Jason)
>
>v6:
>- Move the declaration of static-key to the proper position (Test Robot)
>- Add reported-by tag (Jason)
>- Add more detailed performance test results (Jason)
>
>v5:
>- Change back to nr_cpu_ids (Eric)
>
>v4:
>- Update the wrong commit messages. (Jason)
>
>v3:
>- Change nr_cpu_ids to num_online_cpus() (Maciej)
>- Rename MAX_XDP_QUEUES to IXGBE_MAX_XDP_QS (Maciej)
>- Rename ixgbe_determine_xdp_cpu() to ixgbe_determine_xdp_q_idx()
>(Maciej)
>- Wrap ixgbe_xdp_ring_update_tail() with lock into one function (Maciej)
>
>v2:
>- Adjust cpu id in ixgbe_xdp_xmit(). (Jesper)
>- Add a fallback path. (Maciej)
>- Adjust other parts related to xdp ring.
>---
> drivers/net/ethernet/intel/ixgbe/ixgbe.h           | 23 +++++++++-
> drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c       |  9 +++-
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      | 50 ++++++++++++++++-----
>-
> .../net/ethernet/intel/ixgbe/ixgbe_txrx_common.h   |  3 +-
> drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c       | 16 ++++---
> 5 files changed, 77 insertions(+), 24 deletions(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
