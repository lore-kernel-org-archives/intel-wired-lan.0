From: kbuild test robot <lkp@intel.com>
Date: Sun, 8 Jan 2017 04:52:26 +0800
Subject: [Intel-wired-lan] [next PATCH S58-V2 2/4] i40evf: add client
 interface
In-Reply-To: <1483739589-15480-2-git-send-email-bimmy.pujari@intel.com>
Message-ID: <201701080446.0zorTLKP%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Mitch,

[auto build test ERROR on jkirsher-next-queue/dev-queue]
[cannot apply to v4.10-rc2 next-20170106]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bimmy-Pujari/i40e-shared-fix-up-recent-proxy-and-wol-bits-for-X722_SUPPORT/20170107-193350
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> ERROR: "i40evf_lan_del_device" [drivers/net/ethernet/intel/i40evf/i40evf.ko] undefined!
>> ERROR: "i40evf_notify_client_open" [drivers/net/ethernet/intel/i40evf/i40evf.ko] undefined!
>> ERROR: "i40evf_notify_client_message" [drivers/net/ethernet/intel/i40evf/i40evf.ko] undefined!
>> ERROR: "i40evf_notify_client_l2_params" [drivers/net/ethernet/intel/i40evf/i40evf.ko] undefined!
>> ERROR: "i40evf_lan_add_device" [drivers/net/ethernet/intel/i40evf/i40evf.ko] undefined!
>> ERROR: "i40evf_client_subtask" [drivers/net/ethernet/intel/i40evf/i40evf.ko] undefined!
>> ERROR: "i40evf_notify_client_close" [drivers/net/ethernet/intel/i40evf/i40evf.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 57743 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170108/41cdecba/attachment-0001.bin>
