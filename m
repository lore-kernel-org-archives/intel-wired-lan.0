From: Jarod Wilson <jarod@redhat.com>
Date: Mon, 8 Jun 2020 20:14:28 -0400
Subject: [Intel-wired-lan] [PATCH net-next 3/4] bonding: support
 hardware encryption offload to slaves
In-Reply-To: <20717.1591660112@famine>
References: <20200608210058.37352-1-jarod@redhat.com>
 <20200608210058.37352-4-jarod@redhat.com> <20717.1591660112@famine>
Message-ID: <CAKfmpSfkgC20w3Bp1PCfNJaADU7Hhkk5u9+2cMH+6--b_9cn4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Jun 8, 2020 at 7:48 PM Jay Vosburgh <jay.vosburgh@canonical.com> wrote:
>
> Jarod Wilson <jarod@redhat.com> wrote:
>
> >Currently, this support is limited to active-backup mode, as I'm not sure
> >about the feasilibity of mapping an xfrm_state's offload handle to
> >multiple hardware devices simultaneously, and we rely on being able to
> >pass some hints to both the xfrm and NIC driver about whether or not
> >they're operating on a slave device.
> >
> >I've tested this atop an Intel x520 device (ixgbe) using libreswan in
> >transport mode, succesfully achieving ~4.3Gbps throughput with netperf
> >(more or less identical to throughput on a bare NIC in this system),
> >as well as successful failover and recovery mid-netperf.
> >
> >v2: rebase on latest net-next and wrap with #ifdef CONFIG_XFRM_OFFLOAD
> >v3: add new CONFIG_BOND_XFRM_OFFLOAD option and fix shutdown path
> >
> >CC: Jay Vosburgh <j.vosburgh@gmail.com>
> >CC: Veaceslav Falico <vfalico@gmail.com>
> >CC: Andy Gospodarek <andy@greyhouse.net>
> >CC: "David S. Miller" <davem@davemloft.net>
> >CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> >CC: Jakub Kicinski <kuba@kernel.org>
> >CC: Steffen Klassert <steffen.klassert@secunet.com>
> >CC: Herbert Xu <herbert@gondor.apana.org.au>
> >CC: netdev at vger.kernel.org
> >CC: intel-wired-lan at lists.osuosl.org
> >Signed-off-by: Jarod Wilson <jarod@redhat.com>
> >
> >Signed-off-by: Jarod Wilson <jarod@redhat.com>
> >---
> > drivers/net/Kconfig             |  11 ++++
> > drivers/net/bonding/bond_main.c | 111 +++++++++++++++++++++++++++++++-
> > include/net/bonding.h           |   3 +
> > 3 files changed, 122 insertions(+), 3 deletions(-)
> >
> >diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> >index c7d310ef1c83..938c4dd9bfb9 100644
> >--- a/drivers/net/Kconfig
> >+++ b/drivers/net/Kconfig
> >@@ -56,6 +56,17 @@ config BONDING
> >         To compile this driver as a module, choose M here: the module
> >         will be called bonding.
> >
> >+config BONDING_XFRM_OFFLOAD
> >+      bool "Bonding driver IPSec XFRM cryptography-offload pass-through support"
> >+      depends on BONDING
> >+      depends on XFRM_OFFLOAD
> >+      default y
> >+      select XFRM_ALGO
> >+      ---help---
> >+        Enable support for IPSec offload pass-through in the bonding driver.
> >+        Currently limited to active-backup mode only, and requires slave
> >+        devices that support hardware crypto offload.
> >+
>
>         Why is this a separate Kconfig option?  Is it reasonable to
> expect users to enable XFRM_OFFLOAD but not BONDING_XFRM_OFFLOAD?

I'd originally just wrapped it with XFRM_OFFLOAD, but in an
overabundance of caution, thought maybe gating it behind its own flag
was better. I didn't get any feedback on the initial posting, so I've
been sort of winging it. :)

> >diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> >index a25c65d4af71..01b80cef492a 100644
> >--- a/drivers/net/bonding/bond_main.c
> >+++ b/drivers/net/bonding/bond_main.c
...
> >@@ -4560,6 +4663,8 @@ void bond_setup(struct net_device *bond_dev)
> >                               NETIF_F_HW_VLAN_CTAG_FILTER;
> >
> >       bond_dev->hw_features |= NETIF_F_GSO_ENCAP_ALL | NETIF_F_GSO_UDP_L4;
> >+      if ((BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP))
> >+              bond_dev->hw_features |= BOND_ENC_FEATURES;
>
>         Why is adding the ESP features to hw_features (here, and added
> to BOND_ENC_FEATURES, above) not behind CONFIG_BONDING_XFRM_OFFLOAD?
>
>         If adding these features makes sense regardless of the
> XFRM_OFFLOAD configuration, then shouldn't this change to feature
> handling be a separate patch?  The feature handling is complex, and is
> worth its own patch so it stands out in the log.

No, that would be an oversight by me. The build bot yelled at me on v1
about builds with XFRM_OFFLOAD not enabled, and I neglected to wrap
that bit too.

I'll do that in the next revision. I'm also fine with dropping the
extra kconfig and just using XFRM_OFFLOAD for all of it, if that's
sufficient.

-- 
Jarod Wilson
jarod at redhat.com

