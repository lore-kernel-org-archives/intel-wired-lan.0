From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 15 Feb 2017 11:38:02 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 88/88]
 drivers/net/ethernet/neterion/s2io.c:5351:62: sparse: constant
 10000baseT_Full is not a valid number
Message-ID: <201702151150.yCmP3YrN%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   39877a07fd355416a6f44dfe20832dfdd4b8bdbf
commit: 39877a07fd355416a6f44dfe20832dfdd4b8bdbf [88/88] ethtool: stop the line wrapping madness
reproduce:
        # apt-get install sparse
        git checkout 39877a07fd355416a6f44dfe20832dfdd4b8bdbf
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:253:8: sparse: attribute 'no_sanitize_address': unknown attribute
>> drivers/net/ethernet/neterion/s2io.c:5351:62: sparse: constant 10000baseT_Full is not a valid number
--
   include/linux/compiler.h:253:8: sparse: attribute 'no_sanitize_address': unknown attribute
>> drivers/net/ethernet/neterion/vxge/vxge-ethtool.c:78:62: sparse: constant 10000baseT_Full is not a valid number

vim +5351 drivers/net/ethernet/neterion/s2io.c

^1da177e drivers/net/s2io.c                   Linus Torvalds      2005-04-16  5335   *      s2io_nic structure.
51f21442 drivers/net/ethernet/neterion/s2io.c Philippe Reynes     2017-02-12  5336   * @cmd : pointer to the structure with parameters given by ethtool
^1da177e drivers/net/s2io.c                   Linus Torvalds      2005-04-16  5337   * to return link information.
^1da177e drivers/net/s2io.c                   Linus Torvalds      2005-04-16  5338   * Description:
^1da177e drivers/net/s2io.c                   Linus Torvalds      2005-04-16  5339   * Returns link specific information like speed, duplex etc.. to ethtool.
^1da177e drivers/net/s2io.c                   Linus Torvalds      2005-04-16  5340   * Return value :
^1da177e drivers/net/s2io.c                   Linus Torvalds      2005-04-16  5341   * return 0 on success.
^1da177e drivers/net/s2io.c                   Linus Torvalds      2005-04-16  5342   */
^1da177e drivers/net/s2io.c                   Linus Torvalds      2005-04-16  5343  
51f21442 drivers/net/ethernet/neterion/s2io.c Philippe Reynes     2017-02-12  5344  static int
51f21442 drivers/net/ethernet/neterion/s2io.c Philippe Reynes     2017-02-12  5345  s2io_ethtool_get_link_ksettings(struct net_device *dev,
51f21442 drivers/net/ethernet/neterion/s2io.c Philippe Reynes     2017-02-12  5346  				struct ethtool_link_ksettings *cmd)
^1da177e drivers/net/s2io.c                   Linus Torvalds      2005-04-16  5347  {
4cf1653a drivers/net/s2io.c                   Wang Chen           2008-11-12  5348  	struct s2io_nic *sp = netdev_priv(dev);
1a7eb72b drivers/net/s2io.c                   Sivakumar Subramani 2007-09-14  5349  
51f21442 drivers/net/ethernet/neterion/s2io.c Philippe Reynes     2017-02-12  5350  	ethtool_link_ksettings_zero_link_mode(cmd, supported);
51f21442 drivers/net/ethernet/neterion/s2io.c Philippe Reynes     2017-02-12 @5351  	ethtool_link_ksettings_add_link_mode(cmd, supported, 10000baseT_Full);
51f21442 drivers/net/ethernet/neterion/s2io.c Philippe Reynes     2017-02-12  5352  	ethtool_link_ksettings_add_link_mode(cmd, supported, FIBRE);
51f21442 drivers/net/ethernet/neterion/s2io.c Philippe Reynes     2017-02-12  5353  
51f21442 drivers/net/ethernet/neterion/s2io.c Philippe Reynes     2017-02-12  5354  	ethtool_link_ksettings_zero_link_mode(cmd, advertising);
51f21442 drivers/net/ethernet/neterion/s2io.c Philippe Reynes     2017-02-12  5355  	ethtool_link_ksettings_add_link_mode(cmd, advertising, 10000baseT_Full);
51f21442 drivers/net/ethernet/neterion/s2io.c Philippe Reynes     2017-02-12  5356  	ethtool_link_ksettings_add_link_mode(cmd, advertising, FIBRE);
51f21442 drivers/net/ethernet/neterion/s2io.c Philippe Reynes     2017-02-12  5357  
51f21442 drivers/net/ethernet/neterion/s2io.c Philippe Reynes     2017-02-12  5358  	cmd->base.port = PORT_FIBRE;
^1da177e drivers/net/s2io.c                   Linus Torvalds      2005-04-16  5359  

:::::: The code at line 5351 was first introduced by commit
:::::: 51f21442a210e35e4e726f7d49120b0ed971fe14 net: neterion: s2io: use new api ethtool_{get|set}_link_ksettings

:::::: TO: Philippe Reynes <tremyfr@gmail.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
