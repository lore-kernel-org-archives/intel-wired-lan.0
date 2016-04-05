From: kbuild test robot <lkp@intel.com>
Date: Wed, 6 Apr 2016 01:55:53 +0800
Subject: [Intel-wired-lan] [PATCH net-next 2/2] ixgbe: Add support for
 redirect action to cls_u32 offloads.
In-Reply-To: <1459877947-8241-2-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <201604060142.qDu1fhjS%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Sridhar,

[auto build test WARNING on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Sridhar-Samudrala/net_sched-act_mirred-add-helper-inlines-to-access-tcf_mirred-info/20160406-014537
config: xtensa-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_configure_clsu32':
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8415:8: warning: passing argument 3 of 'parse_tc_actions' from incompatible pointer type
     err = parse_tc_actions(adapter, cls->knode.exts, &input->action,
           ^
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8266:12: note: expected 'u64 *' but argument is of type 'u16 *'
    static int parse_tc_actions(struct ixgbe_adapter *adapter,
               ^

vim +/parse_tc_actions +8415 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

  8399						field_ptr[j].type;
  8400					found_entry = true;
  8401					break;
  8402				}
  8403			}
  8404	
  8405			if (!found_entry)
  8406				goto err_out;
  8407		}
  8408	
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
  8419	
  8420		input->sw_idx = loc;
  8421	
  8422		spin_lock(&adapter->fdir_perfect_lock);
  8423	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 44880 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160406/1939c85b/attachment-0001.obj>
