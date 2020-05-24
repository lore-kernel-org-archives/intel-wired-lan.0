From: kbuild test robot <lkp@intel.com>
Date: Sun, 24 May 2020 19:16:28 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 1768/1945]
 drivers/net/ethernet/mediatek/mtk_star_emac.c:749:29: warning: variable
 'desc' set but not used
Message-ID: <202005241915.LQxjmzXk%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   5950d1e508b225372208a78339e6434adf129852
commit: 8c7bd5a454ffc2b0518d1499c4af95f00291d2af [1768/1945] net: ethernet: mtk-star-emac: new driver
config: arm-allyesconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 8c7bd5a454ffc2b0518d1499c4af95f00291d2af
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

drivers/net/ethernet/mediatek/mtk_star_emac.c: In function 'mtk_star_ring_free_skbs':
>> drivers/net/ethernet/mediatek/mtk_star_emac.c:749:29: warning: variable 'desc' set but not used [-Wunused-but-set-variable]
749 |  struct mtk_star_ring_desc *desc;
|                             ^~~~

vim +/desc +749 drivers/net/ethernet/mediatek/mtk_star_emac.c

   742	
   743	static void
   744	mtk_star_ring_free_skbs(struct mtk_star_priv *priv, struct mtk_star_ring *ring,
   745				void (*unmap_func)(struct mtk_star_priv *,
   746						   struct mtk_star_ring_desc_data *))
   747	{
   748		struct mtk_star_ring_desc_data desc_data;
 > 749		struct mtk_star_ring_desc *desc;
   750		int i;
   751	
   752		for (i = 0; i < MTK_STAR_RING_NUM_DESCS; i++) {
   753			if (!ring->dma_addrs[i])
   754				continue;
   755	
   756			desc = &ring->descs[i];
   757	
   758			desc_data.dma_addr = ring->dma_addrs[i];
   759			desc_data.skb = ring->skbs[i];
   760	
   761			unmap_func(priv, &desc_data);
   762			dev_kfree_skb(desc_data.skb);
   763		}
   764	}
   765	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 74033 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200524/afb396f7/attachment-0001.bin>
