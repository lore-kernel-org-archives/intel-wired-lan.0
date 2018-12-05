From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 05 Dec 2018 13:28:46 -0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 14/17] ERROR:
 "mdiobus_unregister" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
In-Reply-To: <44210b3e-c6df-9e87-2e3c-b2a76ce61980@silicom-usa.com>
References: <201812051354.XWZtO56P%fengguang.wu@intel.com>
 <44210b3e-c6df-9e87-2e3c-b2a76ce61980@silicom-usa.com>
Message-ID: <3ae52f275fbe6b1da8545ed13e7d290ad68b14c5.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2018-12-05 at 19:05 +0000, Steve Douthit wrote:
> On 12/5/18 12:25 AM, kbuild test robot wrote:
> > tree:   
> > https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
> > dev-queue
> > head:   7e1ab79ec66131e03715c31928e09efd1c749cef
> > commit: 444b102251854611659c8569bef3e43049603f7c [14/17] ixgbe:
> > register a mdiobus
> > config: i386-randconfig-s2-12051035 (attached as .config)
> > compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> > reproduce:
> >          git checkout 444b102251854611659c8569bef3e43049603f7c
> >          # save the attached .config to linux build tree
> >          make ARCH=i386
> > 
> > All errors (new ones prefixed by >>):
> > 
> > > > ERROR: "__mdiobus_register"
> > > > [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
> > > > ERROR: "mdiobus_unregister"
> > > > [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
> > > > ERROR: "devm_mdiobus_alloc_size"
> > > > [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
> > > > ERROR: "devm_mdiobus_free"
> > > > [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
> 
> Jeff,
> 
> It looks like I should have had 'select PHYLIB' instead of 'select
> MII'
> in the Kconfig for this patch.
> 
> Would you prefer a v5 or to change that yourself?

:-) v5 please.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20181205/0d2ce836/attachment.asc>
