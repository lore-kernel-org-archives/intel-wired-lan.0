From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed,  2 Dec 2020 16:07:21 +0100
Subject: [Intel-wired-lan] [PATCH net-next 0/3] i40e, ice,
 ixgbe: optimize for XDP_REDIRECT in xsk path
Message-ID: <20201202150724.31439-1-magnus.karlsson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Optimize run_xdp_zc() for the XDP program verdict being XDP_REDIRECT
in the zsk zero-copy path. This path is only used when having AF_XDP
zero-copy on and in that case most packets will be directed to user
space. This provides around 100k extra packets in throughput on my
server when running l2fwd in xdpsock.

Thanks: Magnus

Magnus Karlsson (3):
  i40: optimize for XDP_REDIRECT in xsk path
  ixgbe: optimize for XDP_REDIRECT in xsk path
  ice: optimize for XDP_REDIRECT in xsk path

 drivers/net/ethernet/intel/i40e/i40e_xsk.c   | 11 +++++++----
 drivers/net/ethernet/intel/ice/ice_xsk.c     | 12 ++++++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 11 +++++++----
 3 files changed, 22 insertions(+), 12 deletions(-)


base-commit: 6b4f503186b73e3da24c6716c8c7ea903e6b74d4
--
2.29.0
