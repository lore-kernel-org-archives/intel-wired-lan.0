From: kbuild test robot <lkp@intel.com>
Date: Sun, 23 Jun 2019 11:29:57 +0800
Subject: [Intel-wired-lan] [PATCH net-next v5 5/7] taprio: Add support
 for txtime-assist mode
In-Reply-To: <1561138108-12943-6-git-send-email-vedang.patel@intel.com>
References: <1561138108-12943-6-git-send-email-vedang.patel@intel.com>
Message-ID: <201906231119.X8YmSUCU%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Vedang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Vedang-Patel/net-sched-Add-txtime-assist-support-for-taprio/20190622-192248
config: i386-randconfig-h1-06230338 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: net/sched/sch_taprio.o: in function `length_to_duration':
>> net/sched/sch_taprio.c:154: undefined reference to `__divdi3'
>> ld: net/sched/sch_taprio.c:154: undefined reference to `__divdi3'
>> ld: net/sched/sch_taprio.c:154: undefined reference to `__divdi3'

vim +154 net/sched/sch_taprio.c

   151	
   152	static int length_to_duration(struct taprio_sched *q, int len)
   153	{
 > 154		return (len * atomic64_read(&q->picos_per_byte)) / 1000;
   155	}
   156	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 29195 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190623/915b07e2/attachment-0001.bin>
