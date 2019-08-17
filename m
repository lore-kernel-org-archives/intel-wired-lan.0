From: kbuild test robot <lkp@intel.com>
Date: Sat, 17 Aug 2019 23:04:10 +0800
Subject: [Intel-wired-lan] [PATCH v2 net-next 2/7] ipeh: Move generic EH
 functions to exthdrs_common.c
In-Reply-To: <1565992424-22379-3-git-send-email-tom@herbertland.com>
References: <1565992424-22379-3-git-send-email-tom@herbertland.com>
Message-ID: <201908172247.miJmqlR0%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Tom,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Tom-Herbert/ipv6-Extension-header-infrastructure/20190817-163136
config: x86_64-randconfig-s2-08171511 (attached as .config)
compiler: gcc-5 (Ubuntu 5.5.0-12ubuntu1) 5.5.0 20171010
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from <command-line>:0:0:
>> include/net/ipeh.h:27:15: warning: 'struct ipv6_opt_hdr' declared inside parameter list
           struct ipv6_opt_hdr *newopt);
                  ^
>> include/net/ipeh.h:27:15: warning: its scope is only this definition or declaration, which is probably not what you want

vim +27 include/net/ipeh.h

    21	
    22	struct ipv6_txoptions *ipeh_dup_options(struct sock *sk,
    23						struct ipv6_txoptions *opt);
    24	struct ipv6_txoptions *ipeh_renew_options(struct sock *sk,
    25						  struct ipv6_txoptions *opt,
    26						  int newtype,
  > 27						  struct ipv6_opt_hdr *newopt);
    28	struct ipv6_txoptions *ipeh_fixup_options(struct ipv6_txoptions *opt_space,
    29						  struct ipv6_txoptions *opt);
    30	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28388 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190817/a01ae685/attachment-0001.bin>
