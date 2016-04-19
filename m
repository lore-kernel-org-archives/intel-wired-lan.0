From: Alexander Duyck <aduyck@mirantis.com>
Date: Tue, 19 Apr 2016 15:05:50 -0400
Subject: [Intel-wired-lan] [RFC PATCH 0/5] Add GSO Partial support for
 devices with existing tunnel offloads
Message-ID: <20160419185949.11723.50506.stgit@ahduyck-xeon-server>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch set is meant to extend tunnel offload support for devices that
already support UDP or GRE tunnels to include support for those type of
tunnels with an outer checksum.  To do this I am enabling GSO partial
support for these types of tunnels which should work assuming the devices
supported by these drivers are either overwriting or ignoring checksum and
length fields contained in the IPv4/v6 and ignoring the checksum contained
in the outer L4 tunnel headers.

I don't have any of the hardware that uses the drivers that these patches
are applied do.  That was one of the motivations for submitting them as RFC.
My hope is that somebody out there with this hardware is willing to pull in
the patch and test it out in order to determine if this approach actually
works for these devices.

---

Alexander Duyck (5):
      mlx4: Add support for UDP tunnel segmentation with outer checksum offload
      mlx5: Add support for UDP tunnel segmentation with outer checksum offload
      bnx2x: Add support for segmentation of tunnels with outer checksums
      bnxt: Add support for segmentation of tunnels with outer checksums
      fm10k: Add support for UDP tunnel segmentation with outer checksum offload


 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c  |   13 ++++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         |    9 +++++++--
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c   |   14 ++++++++++----
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c    |   17 +++++++++++++----
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |    7 ++++++-
 5 files changed, 46 insertions(+), 14 deletions(-)

--
