From: kernel test robot <lkp@intel.com>
Date: Thu, 8 Apr 2021 12:41:58 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue 1450/1622]
 drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c:653:14: warning:
 variable 'reg_c1' set but not used
Message-ID: <202104081253.rHApdKrz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
head:   c925dd43dd89b01ff151b5f90beb102b11c40fc3
commit: 7319a1cc3ca9f719e4ef1b1882f6fdb57d0719b8 [1450/1622] net/mlx5e: TC, Refactor tc update skb function
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=7319a1cc3ca9f719e4ef1b1882f6fdb57d0719b8
        git remote add tnguy-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
        git fetch --no-tags tnguy-next-queue dev-queue
        git checkout 7319a1cc3ca9f719e4ef1b1882f6fdb57d0719b8
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c: In function 'mlx5e_rep_tc_update_skb':
>> drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c:653:14: warning: variable 'reg_c1' set but not used [-Wunused-but-set-variable]
     653 |  u32 reg_c0, reg_c1;
         |              ^~~~~~


vim +/reg_c1 +653 drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c

   645	
   646	bool mlx5e_rep_tc_update_skb(struct mlx5_cqe64 *cqe,
   647				     struct sk_buff *skb,
   648				     struct mlx5e_tc_update_priv *tc_priv)
   649	{
   650		struct mlx5_mapped_obj mapped_obj;
   651		struct mlx5_eswitch *esw;
   652		struct mlx5e_priv *priv;
 > 653		u32 reg_c0, reg_c1;
   654		int err;
   655	
   656		reg_c0 = (be32_to_cpu(cqe->sop_drop_qpn) & MLX5E_TC_FLOW_ID_MASK);
   657		if (!reg_c0 || reg_c0 == MLX5_FS_DEFAULT_FLOW_TAG)
   658			return true;
   659	
   660		/* If reg_c0 is not equal to the default flow tag then skb->mark
   661		 * is not supported and must be reset back to 0.
   662		 */
   663		skb->mark = 0;
   664	
   665		reg_c1 = be32_to_cpu(cqe->ft_metadata);
   666	
   667		priv = netdev_priv(skb->dev);
   668		esw = priv->mdev->priv.eswitch;
   669		err = mapping_find(esw->offloads.reg_c0_obj_pool, reg_c0, &mapped_obj);
   670		if (err) {
   671			netdev_dbg(priv->netdev,
   672				   "Couldn't find mapped object for reg_c0: %d, err: %d\n",
   673				   reg_c0, err);
   674			return false;
   675		}
   676	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 53797 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210408/7ea2861b/attachment-0001.bin>
