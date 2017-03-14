From: Philippe Reynes <tremyfr@gmail.com>
Date: Tue, 14 Mar 2017 22:42:05 +0100
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 56/91]
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:393:6: error:
 redeclaration of 'supported' with no linkage
In-Reply-To: <201703141619.EfULrjB2%fengguang.wu@intel.com>
References: <201703141619.EfULrjB2%fengguang.wu@intel.com>
Message-ID: <CAC=8w91fFXcSRHGgiFkJwiPXsB7CihUAa0GHaTo0AkJRO9R2bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

I don't reproduce this issue on the git net-next.
I've looked on git jkirsher/next-queue.git, and I
think that the issue is raised because my patch
was integrated twice :

13 hours	ixgbe: use new api ethtool_{get|set}_link_ksettings
43 hours	net: intel: ixgbe: use new api ethtool_{get|set}_link_ksettings

Regards,
Philippe


On 3/14/17, kbuild test robot <fengguang.wu@intel.com> wrote:
> tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
> dev-queue
> head:   58f90b91f8d9ef78ec305e1d3db1f94a5f711ff3
> commit: d758c65b73ae233802b736b12ac77e4b48e58dc3 [56/91] ixgbe: use new api
> ethtool_{get|set}_link_ksettings
> config: i386-randconfig-x018-201711 (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         git checkout d758c65b73ae233802b736b12ac77e4b48e58dc3
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All errors (new ones prefixed by >>):
>
>    drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c: In function
> 'ixgbe_set_link_ksettings':
>>> drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:393:6: error:
>>> redeclaration of 'supported' with no linkage
>      u32 supported, advertising;
>          ^~~~~~~~~
>    drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:390:6: note: previous
> declaration of 'supported' was here
>      u32 supported, advertising;
>          ^~~~~~~~~
>>> drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:393:17: error:
>>> redeclaration of 'advertising' with no linkage
>      u32 supported, advertising;
>                     ^~~~~~~~~~~
>    drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:390:17: note: previous
> declaration of 'advertising' was here
>      u32 supported, advertising;
>                     ^~~~~~~~~~~
>
> vim +/supported +393 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>
> 9a799d71 drivers/net/ixgbe/ixgbe_ethtool.c                Auke Kok
>       2007-09-15  387  {
> 9a799d71 drivers/net/ixgbe/ixgbe_ethtool.c                Auke Kok
>       2007-09-15  388  	struct ixgbe_adapter *adapter =
> netdev_priv(netdev);
> 735441fb drivers/net/ixgbe/ixgbe_ethtool.c                Ayyappan Veeraiyan
>       2008-02-01  389  	struct ixgbe_hw *hw = &adapter->hw;
> d758c65b drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c Philippe Reynes
>       2017-03-14  390  	u32 supported, advertising;
> 0befdb3e drivers/net/ixgbe/ixgbe_ethtool.c                Jesse Brandeburg
>       2008-10-31  391  	u32 advertised, old;
> 74766013 drivers/net/ixgbe/ixgbe_ethtool.c                Mallikarjuna R
> Chilakala 2009-06-04  392  	s32 err = 0;
> 8704f21c drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c Philippe Reynes
>       2017-03-07 @393  	u32 supported, advertising;
> 8704f21c drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c Philippe Reynes
>       2017-03-07  394
> 8704f21c drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c Philippe Reynes
>       2017-03-07  395  	ethtool_convert_link_mode_to_legacy_u32(&supported,
> 8704f21c drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c Philippe Reynes
>       2017-03-07  396  						cmd->link_modes.supported);
>
> :::::: The code at line 393 was first introduced by commit
> :::::: 8704f21c8449d4ee0ea22a16014b6af6e757ec81 net: intel: ixgbe: use new
> api ethtool_{get|set}_link_ksettings
>
> :::::: TO: Philippe Reynes <tremyfr@gmail.com>
> :::::: CC: David S. Miller <davem@davemloft.net>
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology
> Center
> https://lists.01.org/pipermail/kbuild-all                   Intel
> Corporation
>
