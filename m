From: kbuild test robot <lkp@intel.com>
Date: Wed, 6 Apr 2016 01:57:46 +0800
Subject: [Intel-wired-lan] [PATCH net-next 2/2] ixgbe: Add support for
 redirect action to cls_u32 offloads.
In-Reply-To: <1459877947-8241-2-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <201604060108.m8lwuShU%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Sridhar,

[auto build test ERROR on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Sridhar-Samudrala/net_sched-act_mirred-add-helper-inlines-to-access-tcf_mirred-info/20160406-014537
config: x86_64-randconfig-x010-201614 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_configure_clsu32':
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8415:51: error: passing argument 3 of 'parse_tc_actions' from incompatible pointer type [-Werror=incompatible-pointer-types]
     err = parse_tc_actions(adapter, cls->knode.exts, &input->action,
                                                      ^
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8298:12: note: expected 'u64 * {aka long long unsigned int *}' but argument is of type 'u16 * {aka short unsigned int *}'
    static int parse_tc_actions(struct ixgbe_adapter *adapter,
               ^
   cc1: some warnings being treated as errors

vim +/parse_tc_actions +8415 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

  8409		mask.formatted.flow_type = IXGBE_ATR_L4TYPE_IPV6_MASK |
  8410					   IXGBE_ATR_L4TYPE_MASK;
  8411	
  8412		if (input->filter.formatted.flow_type == IXGBE_ATR_FLOW_TYPE_IPV4)
  8413			mask.formatted.flow_type &= IXGBE_ATR_L4TYPE_IPV6_MASK;
  8414	
> 8415		err = parse_tc_actions(adapter, cls->knode.exts, &input->action,
  8416				       &queue);
  8417		if (err < 0)
  8418			goto err_out;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 32342 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160406/ab4c355d/attachment-0001.obj>
