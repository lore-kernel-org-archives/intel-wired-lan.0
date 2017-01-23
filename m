From: kbuild test robot <fengguang.wu@intel.com>
Date: Mon, 23 Jan 2017 10:15:57 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 79/82]
 drivers/net/ethernet/intel/igb/igb_main.c:6997:7: error: invalid operands
 to binary - (have 'unsigned char *' and 'void *')
Message-ID: <201701231055.iNzp1w9o%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   b5c90f3b454d813f16a3c4abe4df9ea0b60e7947
commit: 3115d9a0076859df620c7dbab4cb0323db31ab3c [79/82] igb: Add support for padding packet
config: x86_64-lkp (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 3115d9a0076859df620c7dbab4cb0323db31ab3c
        # save the attached .config to linux build tree
        make ARCH=x86_64 

Note: the jkirsher-next-queue/dev-queue HEAD b5c90f3b454d813f16a3c4abe4df9ea0b60e7947 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/igb/igb_main.c: In function 'igb_add_rx_frag':
>> drivers/net/ethernet/intel/igb/igb_main.c:6997:7: error: invalid operands to binary - (have 'unsigned char *' and 'void *')
       va - page_address(page), size, truesize);
          ^

vim +6997 drivers/net/ethernet/intel/igb/igb_main.c

  6991		/* update all of the pointers */
  6992		va += pull_len;
  6993		size -= pull_len;
  6994	
  6995	add_tail_frag:
  6996		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page,
> 6997				va - page_address(page), size, truesize);
  6998	
  6999		return igb_can_reuse_rx_page(rx_buffer, page, truesize);
  7000	}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 24661 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170123/6241ebb0/attachment-0001.bin>
