From: kernel test robot <lkp@intel.com>
Date: Sat, 3 Jul 2021 02:43:46 +0800
Subject: [Intel-wired-lan] [PATCH] iavf: remove redundant null check on
 key
In-Reply-To: <20210702112720.16006-1-colin.king@canonical.com>
References: <20210702112720.16006-1-colin.king@canonical.com>
Message-ID: <202107030209.xwGHO2JN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Colin,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tnguy-next-queue/dev-queue]
[also build test WARNING on v5.13 next-20210701]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Colin-King/iavf-remove-redundant-null-check-on-key/20210702-192826
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/59ac04f9a577d107d282cd2c5ef80272a7ad40f7
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Colin-King/iavf-remove-redundant-null-check-on-key/20210702-192826
        git checkout 59ac04f9a577d107d282cd2c5ef80272a7ad40f7
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=ia64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/iavf/iavf_ethtool.c: In function 'iavf_set_rxfh':
>> drivers/net/ethernet/intel/iavf/iavf_ethtool.c:1912:2: warning: argument 2 null where non-null expected [-Wnonnull]
    1912 |  memcpy(adapter->rss_key, key, adapter->rss_key_size);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/string.h:21,
                    from include/linux/bitmap.h:10,
                    from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:59,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:16,
                    from drivers/net/ethernet/intel/iavf/iavf.h:7,
                    from drivers/net/ethernet/intel/iavf/iavf_ethtool.c:5:
   arch/ia64/include/asm/string.h:19:14: note: in a call to function 'memcpy' declared here
      19 | extern void *memcpy (void *, const void *, __kernel_size_t);
         |              ^~~~~~


vim +1912 drivers/net/ethernet/intel/iavf/iavf_ethtool.c

4e9dc31f696ae8 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Mitch A Williams 2014-04-01  1888  
4e9dc31f696ae8 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Mitch A Williams 2014-04-01  1889  /**
129cf89e585676 drivers/net/ethernet/intel/iavf/i40evf_ethtool.c   Jesse Brandeburg 2018-09-14  1890   * iavf_set_rxfh - set the rx flow hash indirection table
4e9dc31f696ae8 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Mitch A Williams 2014-04-01  1891   * @netdev: network interface device structure
4e9dc31f696ae8 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Mitch A Williams 2014-04-01  1892   * @indir: indirection table
2cda3f3be5c2f6 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Mitch Williams   2014-11-11  1893   * @key: hash key
f5254429e1756a drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Jacob Keller     2018-04-20  1894   * @hfunc: hash function to use
4e9dc31f696ae8 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Mitch A Williams 2014-04-01  1895   *
4e9dc31f696ae8 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Mitch A Williams 2014-04-01  1896   * Returns -EINVAL if the table specifies an inavlid queue id, otherwise
4e9dc31f696ae8 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Mitch A Williams 2014-04-01  1897   * returns 0 after programming the table.
4e9dc31f696ae8 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Mitch A Williams 2014-04-01  1898   **/
129cf89e585676 drivers/net/ethernet/intel/iavf/i40evf_ethtool.c   Jesse Brandeburg 2018-09-14  1899  static int iavf_set_rxfh(struct net_device *netdev, const u32 *indir,
892311f66f2411 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Eyal Perry       2014-12-02  1900  			 const u8 *key, const u8 hfunc)
4e9dc31f696ae8 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Mitch A Williams 2014-04-01  1901  {
129cf89e585676 drivers/net/ethernet/intel/iavf/i40evf_ethtool.c   Jesse Brandeburg 2018-09-14  1902  	struct iavf_adapter *adapter = netdev_priv(netdev);
2c86ac3c70794f drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Helin Zhang      2015-10-27  1903  	u16 i;
4e9dc31f696ae8 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Mitch A Williams 2014-04-01  1904  
892311f66f2411 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Eyal Perry       2014-12-02  1905  	/* We do not allow change in unsupported parameters */
892311f66f2411 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Eyal Perry       2014-12-02  1906  	if (key ||
892311f66f2411 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Eyal Perry       2014-12-02  1907  	    (hfunc != ETH_RSS_HASH_NO_CHANGE && hfunc != ETH_RSS_HASH_TOP))
892311f66f2411 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Eyal Perry       2014-12-02  1908  		return -EOPNOTSUPP;
892311f66f2411 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Eyal Perry       2014-12-02  1909  	if (!indir)
892311f66f2411 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Eyal Perry       2014-12-02  1910  		return 0;
892311f66f2411 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Eyal Perry       2014-12-02  1911  
43a3d9ba34c9ca drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Mitch Williams   2016-04-12 @1912  	memcpy(adapter->rss_key, key, adapter->rss_key_size);
4e9dc31f696ae8 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Mitch A Williams 2014-04-01  1913  
2c86ac3c70794f drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Helin Zhang      2015-10-27  1914  	/* Each 32 bits pointed by 'indir' is stored with a lut entry */
43a3d9ba34c9ca drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Mitch Williams   2016-04-12  1915  	for (i = 0; i < adapter->rss_lut_size; i++)
43a3d9ba34c9ca drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Mitch Williams   2016-04-12  1916  		adapter->rss_lut[i] = (u8)(indir[i]);
2c86ac3c70794f drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Helin Zhang      2015-10-27  1917  
129cf89e585676 drivers/net/ethernet/intel/iavf/i40evf_ethtool.c   Jesse Brandeburg 2018-09-14  1918  	return iavf_config_rss(adapter);
4e9dc31f696ae8 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Mitch A Williams 2014-04-01  1919  }
4e9dc31f696ae8 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c Mitch A Williams 2014-04-01  1920  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 64298 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210703/12104cb0/attachment-0001.bin>
