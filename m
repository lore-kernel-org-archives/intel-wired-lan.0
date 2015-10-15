From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 15 Oct 2015 19:15:36 +0000
Subject: [Intel-wired-lan] [net-next PATCH v1] drivers/net/intel:
	use	napi_complete_done()
In-Reply-To: <20150924233547.15221.59274.stgit@jbrandeb-hsm1.jf.intel.com>
References: <20150924233547.15221.59274.stgit@jbrandeb-hsm1.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D1E0C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Thursday, September 24, 2015 4:36 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next PATCH v1] drivers/net/intel: use
> napi_complete_done()
> 
> As per Eric Dumazet's previous patches:
> (see commit (24d2e4a50737) - tg3: use napi_complete_done())
> 
> Quoting verbatim:
> Using napi_complete_done() instead of napi_complete() allows us to use
> /sys/class/net/ethX/gro_flush_timeout
> 
> GRO layer can aggregate more packets if the flush is delayed a bit, without
> having to set too big coalescing parameters that impact latencies.
> </end quote>
> 
> Tested
> configuration: low latency via ethtool -C ethx adaptive-rx off
> 				rx-usecs 10 adaptive-tx off tx-usecs 15
> workload: streaming rx using netperf TCP_MAERTS
> 
> igb:
> # ethtool -C enp5s0f0 rx-usecs 10
> # echo 0 >  /sys/class/net/enp5s0f0/gro_flush_timeout
> # netperf -H 10.0.0.1 -t TCP_MAERTS -D1 -v9 MIGRATED TCP MAERTS TEST
> from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 10.0.0.1 () port 0 AF_INET : demo ...
> Interim result:  941.48 10^6bits/s over 1.000 seconds ending at
> 1440193171.589
> 
> Alignment      Offset         Bytes    Bytes       Recvs   Bytes    Sends
> Local  Remote  Local  Remote  Xfered   Per                 Per
> Recv   Send    Recv   Send             Recv (avg)          Send (avg)
>     8       8      0       0 1176930056  1475.36    797726   16384.00  71905
> 
> # echo 10000 >  /sys/class/net/enp5s0f0/gro_flush_timeout
> # netperf -H 10.0.0.1 -t TCP_MAERTS D1 -v9 MIGRATED TCP MAERTS TEST
> from 0.0.0.0 (0.0.0.0) port 0 AF_INET to 10.0.0.1 () port 0 AF_INET : demo ...
> Interim result:  941.49 10^6bits/s over 0.997 seconds ending at
> 1440193142.763
> 
> Alignment      Offset         Bytes    Bytes       Recvs   Bytes    Sends
> Local  Remote  Local  Remote  Xfered   Per                 Per
> Recv   Send    Recv   Send             Recv (avg)          Send (avg)
>     8       8      0       0 1175182320  50476.00     23282   16384.00  71816
> 
> i40e:
> Hard to test because the traffic is incoming so fast (24Gb/s) that GRO always
> receives 87kB, even at the highest interrupt rate.
> 
> Other drivers were only compile tested.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> CC: Don Skidmore <donald.c.skidmore@intel.com>
> CC: Todd Fujinaka <todd.fujinaka@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_main.c     |    2 +-
>  drivers/net/ethernet/intel/e1000e/netdev.c        |    2 +-
>  drivers/net/ethernet/intel/fm10k/fm10k_main.c     |   21 ++++++++++++----
> -----
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c       |    8 ++++++--
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c     |    8 ++++++--
>  drivers/net/ethernet/intel/igb/igb_main.c         |   17 +++++++++++------
>  drivers/net/ethernet/intel/igbvf/netdev.c         |    2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |   14 +++++++++-----
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   14 ++++++++------
>  9 files changed, 55 insertions(+), 33 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied (i40e/i40evf)
