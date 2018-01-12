From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 13 Jan 2018 04:13:10 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 99/109]
 include/linux/avf/virtchnl.h:523:31: error: enumerator value for
 'virtchnl_static_assert_virtchnl_tc_info' is not an integer constant
Message-ID: <201801130406.DQT92ouv%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   5a2f5288e8033ca6995630146eb61790471d9542
commit: bb6ac9bef16595d9d403450d53e549bf8a7c26fc [99/109] virtchnl: Add virtchl structures to support queue channels
config: i386-randconfig-x076-201801 (attached as .config)
compiler: gcc-7 (Debian 7.2.0-12) 7.2.1 20171025
reproduce:
        git checkout bb6ac9bef16595d9d403450d53e549bf8a7c26fc
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   In file included from drivers/net//ethernet/intel/i40e/i40e_prototype.h:32:0,
                    from drivers/net//ethernet/intel/i40e/i40e.h:61,
                    from drivers/net//ethernet/intel/i40e/i40e_main.c:33:
>> include/linux/avf/virtchnl.h:149:36: warning: division by zero [-Wdiv-by-zero]
     { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
                                       ^
>> include/linux/avf/virtchnl.h:523:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
    VIRTCHNL_CHECK_STRUCT_LEN(24, virtchnl_tc_info);
    ^~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/avf/virtchnl.h:523:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_tc_info' is not an integer constant
    VIRTCHNL_CHECK_STRUCT_LEN(24, virtchnl_tc_info);
                                  ^
   include/linux/avf/virtchnl.h:149:53: note: in definition of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
     { virtchnl_static_assert_##X = (n)/((sizeof(struct X) == (n)) ? 1 : 0) }
                                                        ^

vim +/virtchnl_static_assert_virtchnl_tc_info +523 include/linux/avf/virtchnl.h

   522	
 > 523	VIRTCHNL_CHECK_STRUCT_LEN(24, virtchnl_tc_info);
   524	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 29845 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180113/8362f014/attachment-0001.bin>
