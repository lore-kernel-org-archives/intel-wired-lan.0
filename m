From: kbuild test robot <lkp@intel.com>
Date: Thu, 20 Jun 2019 01:33:16 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 1033/1070]
 drivers/net/ethernet/huawei/hinic/hinic_main.c:418:1: warning: the frame
 size of 1072 bytes is larger than 1024 bytes
Message-ID: <201906200114.j0sQWZ56%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   b983e9611fa830796683940df884ea8c3260834f
commit: 421e9526288b6ec241b46153493884277cbb533f [1033/1070] hinic: add rss support
config: i386-randconfig-n004-201924 (attached as .config)
compiler: gcc-5 (Debian 5.5.0-3) 5.4.1 20171010
reproduce:
        git checkout 421e9526288b6ec241b46153493884277cbb533f
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/huawei/hinic/hinic_main.c: In function 'hinic_rss_init':
>> drivers/net/ethernet/huawei/hinic/hinic_main.c:418:1: warning: the frame size of 1072 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    }
    ^

vim +418 drivers/net/ethernet/huawei/hinic/hinic_main.c

   384	
   385	static int hinic_rss_init(struct hinic_dev *nic_dev)
   386	{
   387		u32 indir_tbl[HINIC_RSS_INDIR_SIZE] = { 0 };
   388		u8 default_rss_key[HINIC_RSS_KEY_SIZE];
   389		u8 tmpl_idx = nic_dev->rss_tmpl_idx;
   390		int err, i;
   391	
   392		netdev_rss_key_fill(default_rss_key, sizeof(default_rss_key));
   393		for (i = 0; i < HINIC_RSS_INDIR_SIZE; i++)
   394			indir_tbl[i] = ethtool_rxfh_indir_default(i, nic_dev->num_rss);
   395	
   396		err = hinic_rss_set_template_tbl(nic_dev, tmpl_idx, default_rss_key);
   397		if (err)
   398			return err;
   399	
   400		err = hinic_rss_set_indir_tbl(nic_dev, tmpl_idx, indir_tbl);
   401		if (err)
   402			return err;
   403	
   404		err = hinic_set_rss_type(nic_dev, tmpl_idx, nic_dev->rss_type);
   405		if (err)
   406			return err;
   407	
   408		err = hinic_rss_set_hash_engine(nic_dev, tmpl_idx,
   409						nic_dev->rss_hash_engine);
   410		if (err)
   411			return err;
   412	
   413		err = hinic_rss_cfg(nic_dev, 1, tmpl_idx);
   414		if (err)
   415			return err;
   416	
   417		return 0;
 > 418	}
   419	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 43014 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190620/37c21643/attachment-0001.bin>
