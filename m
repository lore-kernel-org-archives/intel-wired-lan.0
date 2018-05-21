From: kbuild test robot <lkp@intel.com>
Date: Tue, 22 May 2018 03:51:00 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 25/25]
 drivers/infiniband/hw/i40iw/i40iw_main.c:110:6: sparse: symbol
 'i40iw_open_inc_ref' was not declared. Should it be static?
Message-ID: <201805220348.Z5yGrkGk%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   34a1361d548da593a1bf5937f386f60b07874d6b
commit: 34a1361d548da593a1bf5937f386f60b07874d6b [25/25] i40iw/i40e: Remove link dependency on i40e
reproduce:
        # apt-get install sparse
        git checkout 34a1361d548da593a1bf5937f386f60b07874d6b
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/infiniband/hw/i40iw/i40iw_main.c:110:6: sparse: symbol 'i40iw_open_inc_ref' was not declared. Should it be static?
>> drivers/infiniband/hw/i40iw/i40iw_main.c:118:6: sparse: symbol 'i40iw_open_dec_ref' was not declared. Should it be static?
   drivers/infiniband/hw/i40iw/i40iw_main.c:819:20: sparse: expression using sizeof(void)
   drivers/infiniband/hw/i40iw/i40iw_main.c:819:20: sparse: expression using sizeof(void)

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
