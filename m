From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 4 Mar 2022 11:58:58 +0300
Subject: [Intel-wired-lan] [tnguy-next-queue:100GbE 179/215]
 net/dsa/dsa.c:486 dsa_port_walk_fdbs() error: uninitialized symbol 'err'.
Message-ID: <202203041527.OdG5EuV4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 100GbE
head:   3d5985a185e6abfc0b38ed187819016a79eca864
commit: f9cef64fa23f6c1ff177be5082113c5a94e34e5d [179/215] net: dsa: felix: migrate host FDB and MDB entries when changing tag proto
config: m68k-randconfig-m031-20220304 (https://download.01.org/0day-ci/archive/20220304/202203041527.OdG5EuV4-lkp at intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
net/dsa/dsa.c:486 dsa_port_walk_fdbs() error: uninitialized symbol 'err'.
net/dsa/dsa.c:506 dsa_port_walk_mdbs() error: uninitialized symbol 'err'.

vim +/err +486 net/dsa/dsa.c

f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  470  int dsa_port_walk_fdbs(struct dsa_switch *ds, int port, dsa_fdb_walk_cb_t cb)
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  471  {
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  472  	struct dsa_port *dp = dsa_to_port(ds, port);
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  473  	struct dsa_mac_addr *a;
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  474  	int err;
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  475  
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  476  	mutex_lock(&dp->addr_lists_lock);
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  477  
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  478  	list_for_each_entry(a, &dp->fdbs, list) {

Can the list be empty?  Smatch might be able to figure this out with
cross function analysis but it's not feasible for the kbuild-bot.

f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  479  		err = cb(ds, port, a->addr, a->vid, a->db);
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  480  		if (err)
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  481  			break;
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  482  	}
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  483  
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  484  	mutex_unlock(&dp->addr_lists_lock);
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  485  
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02 @486  	return err;
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  487  }
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  488  EXPORT_SYMBOL_GPL(dsa_port_walk_fdbs);
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  489  
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  490  int dsa_port_walk_mdbs(struct dsa_switch *ds, int port, dsa_fdb_walk_cb_t cb)
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  491  {
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  492  	struct dsa_port *dp = dsa_to_port(ds, port);
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  493  	struct dsa_mac_addr *a;
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  494  	int err;
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  495  
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  496  	mutex_lock(&dp->addr_lists_lock);
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  497  
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  498  	list_for_each_entry(a, &dp->mdbs, list) {
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  499  		err = cb(ds, port, a->addr, a->vid, a->db);
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  500  		if (err)
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  501  			break;
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  502  	}
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  503  
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  504  	mutex_unlock(&dp->addr_lists_lock);
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  505  
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02 @506  	return err;
f9cef64fa23f6c1 Vladimir Oltean 2022-03-02  507  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org

