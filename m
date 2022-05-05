From: Leon Romanovsky <leon@kernel.org>
Date: Thu,  5 May 2022 13:06:37 +0300
Subject: [Intel-wired-lan] [PATCH ipsec-next 0/8] Be explicit with XFRM
 offload direction
Message-ID: <cover.1651743750.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Leon Romanovsky <leonro@nvidia.com>

Hi Steffen,

I may admit that the title of this series is not the best one as it
contains straightforward cleanups and code that converts flags to
something less confusing.

This series follows removal of FPGA IPsec code from the mlx5 driver and
based on net-next commit 4950b6990e3b ("Merge branch 'ocelot-vcap-cleanups'").

As such, first two patches delete code that was used by mlx5 FPGA code
but isn't needed anymore.

Third patch is simple struct rename.

Rest of the patches separate user's provided flags variable from driver's
usage. This allows us to created more simple in-kernel interface, that
supports type checking without blending different properties into one
variable. It is achieved by converting flags to specific bitfield variables
with clear, meaningful names.
    
Such change allows us more clear addition of new input flags needed to
mark IPsec offload type.

The followup code uses this extensively:
https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/log/?h=xfrm-next

Thanks

Leon Romanovsky (8):
  xfrm: free not used XFRM_ESP_NO_TRAILER flag
  xfrm: delete not used number of external headers
  xfrm: rename xfrm_state_offload struct to allow reuse
  xfrm: store and rely on direction to construct offload flags
  ixgbe: propagate XFRM offload state direction instead of flags
  netdevsim: rely on XFRM state direction instead of flags
  net/mlx5e: Use XFRM state direction instead of flags
  xfrm: drop not needed flags variable in XFRM offload struct

 .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    |  9 ++++-----
 .../net/ethernet/intel/ixgbe/ixgbe_ipsec.h    |  2 +-
 drivers/net/ethernet/intel/ixgbevf/ipsec.c    |  6 +++---
 drivers/net/ethernet/intel/ixgbevf/ipsec.h    |  2 +-
 .../mellanox/mlx5/core/en_accel/ipsec.c       | 10 +++++-----
 drivers/net/netdevsim/ipsec.c                 |  2 +-
 include/net/xfrm.h                            | 20 +++++++++++--------
 net/ipv4/esp4.c                               |  6 ------
 net/ipv6/esp6.c                               |  6 ------
 net/xfrm/xfrm_device.c                        | 15 +++++++-------
 net/xfrm/xfrm_state.c                         |  4 ++--
 net/xfrm/xfrm_user.c                          |  5 +++--
 12 files changed, 40 insertions(+), 47 deletions(-)

-- 
2.35.1

