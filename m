From: kernel test robot <lkp@intel.com>
Date: Tue, 26 Apr 2022 18:23:14 +0800
Subject: [Intel-wired-lan] [PATCH net-next v4 1/2] rtnetlink: add extack
 support in fdb del handlers
In-Reply-To: <8847c5d670c7ee11890d75f58a4922c5cb542f20.1650896000.git.eng.alaamohamedsoliman.am@gmail.com>
References: <8847c5d670c7ee11890d75f58a4922c5cb542f20.1650896000.git.eng.alaamohamedsoliman.am@gmail.com>
Message-ID: <202204261831.S6mBmtgP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Alaa,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on horms-ipvs/master]
[also build test ERROR on net/master linus/master v5.18-rc4]
[cannot apply to net-next/master next-20220422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Alaa-Mohamed/propagate-extack-to-vxlan_fdb_delete/20220425-222644
base:   https://git.kernel.org/pub/scm/linux/kernel/git/horms/ipvs.git master
config: riscv-randconfig-r002-20220425 (https://download.01.org/0day-ci/archive/20220426/202204261831.S6mBmtgP-lkp at intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/5e9c3e146040a4e37b45ca18c3b42c3dfd6d0a0e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Alaa-Mohamed/propagate-extack-to-vxlan_fdb_delete/20220425-222644
        git checkout 5e9c3e146040a4e37b45ca18c3b42c3dfd6d0a0e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/net/ethernet/mscc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/mscc/ocelot_net.c:784:70: error: too many arguments to function call, expected 5, have 6
           return ocelot_fdb_del(ocelot, port, addr, vid, ocelot_port->bridge, extack);
                  ~~~~~~~~~~~~~~                                               ^~~~~~
   include/soc/mscc/ocelot.h:893:5: note: 'ocelot_fdb_del' declared here
   int ocelot_fdb_del(struct ocelot *ocelot, int port, const unsigned char *addr,
       ^
   1 error generated.


vim +784 drivers/net/ethernet/mscc/ocelot_net.c

   774	
   775	static int ocelot_port_fdb_del(struct ndmsg *ndm, struct nlattr *tb[],
   776				       struct net_device *dev,
   777				       const unsigned char *addr, u16 vid, struct netlink_ext_ack *extack)
   778	{
   779		struct ocelot_port_private *priv = netdev_priv(dev);
   780		struct ocelot_port *ocelot_port = &priv->port;
   781		struct ocelot *ocelot = ocelot_port->ocelot;
   782		int port = priv->chip_port;
   783	
 > 784		return ocelot_fdb_del(ocelot, port, addr, vid, ocelot_port->bridge, extack);
   785	}
   786	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
