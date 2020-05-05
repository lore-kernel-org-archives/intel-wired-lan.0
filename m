From: Jarod Wilson <jarod@redhat.com>
Date: Tue,  5 May 2020 18:58:35 -0400
Subject: [Intel-wired-lan] [RFC PATCH net-next v2 0/3] bonding: support
 hardware crypto offload
In-Reply-To: <20200504145943.8841-1-jarod@redhat.com>
References: <20200504145943.8841-1-jarod@redhat.com>
Message-ID: <20200505225838.59505-1-jarod@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This is an initial "proof of concept" functional implementation for doing
pass-through of hardware encryption from bonding device to capable slaves.
This was tested using an ixgbe-driven Intel x520 NIC with libreswan and a
transport mode connection, on top of an active-backup bond, using netperf
and downing an interface during. Failover takes a moment, but does work,
and overall performance is right on par with offload when running on a
bare interface.

Caveats: this is ONLY enabled for active-backup, because I'm not sure
how one would manage multiple offload handles for different devices all
running at the same time in the same xfrm, and it relies on some minor
changes to both the xfrm code and slave device driver code to get things
to behave, and I don't have immediate access to any other hardware that
could function similarly to update driver code accordingly.

I'm hoping folks with more of an idea about xfrm have some thoughts on
ways to make this cleaner, and possibly support more bonding modes, but
I'm reasonably happy I've made it this far. :)

v2: fix build with CONFIG_XFRM_OFFLOAD disabled and rebase on latest
    net-next tree bonding changes

CC: Jay Vosburgh <j.vosburgh@gmail.com>
CC: Veaceslav Falico <vfalico@gmail.com>
CC: Andy Gospodarek <andy@greyhouse.net>
CC: "David S. Miller" <davem@davemloft.net>
CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>
CC: netdev at vger.kernel.org
CC: intel-wired-lan at lists.osuosl.org

Jarod Wilson (3):
  xfrm: bail early on slave pass over skb
  ixgbe_ipsec: become aware of when running as a bonding slave
  bonding: support hardware encryption offload to slaves

 drivers/net/bonding/bond_main.c               | 111 +++++++++++++++++-
 .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    |  39 ++++--
 include/net/bonding.h                         |   3 +
 include/net/xfrm.h                            |   1 +
 net/xfrm/xfrm_device.c                        |  34 +++---
 5 files changed, 160 insertions(+), 28 deletions(-)

-- 
2.20.1

