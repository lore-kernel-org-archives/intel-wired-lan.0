From: kernel test robot <lkp@intel.com>
Date: Fri, 26 Jun 2020 07:00:50 +0800
Subject: [Intel-wired-lan] [PATCH 1/1] igb: add XDP support
In-Reply-To: <20200625155014.6zwfoqqyhsvwu2gc@SvensMacBookAir.sven.lan>
References: <20200625155014.6zwfoqqyhsvwu2gc@SvensMacBookAir.sven.lan>
Message-ID: <202006260609.pvrBZeWn%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Sven,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v5.8-rc2]
[also build test WARNING on next-20200625]
[cannot apply to jkirsher-next-queue/dev-queue]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use  as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sven-Auhagen/igb-add-XDP-support/20200626-052800
base:    48778464bb7d346b47157d21ffde2af6b2d39110
config: mips-ip27_defconfig (attached as .config)
compiler: mips64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/igb/igb_main.c:2896:6: warning: no previous prototype for 'igb_xdp_ring_update_tail' [-Wmissing-prototypes]
    2896 | void igb_xdp_ring_update_tail(struct igb_ring *ring)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~

vim +/igb_xdp_ring_update_tail +2896 drivers/net/ethernet/intel/igb/igb_main.c

  2895	
> 2896	void igb_xdp_ring_update_tail(struct igb_ring *ring)
  2897	{
  2898		/* Force memory writes to complete before letting h/w know there
  2899		 * are new descriptors to fetch.
  2900		 */
  2901		wmb();
  2902		writel(ring->next_to_use, ring->tail);
  2903	}
  2904	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 17774 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200626/169d9844/attachment.bin>
