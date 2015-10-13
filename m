From: kbuild test robot <lkp@intel.com>
Date: Tue, 13 Oct 2015 10:03:01 +0800
Subject: [Intel-wired-lan] [PATCH v4 2/4] Always running timer
	correlated clocksource
In-Reply-To: <1444675522-4198-3-git-send-email-christopher.s.hall@intel.com>
Message-ID: <201510131029.2Uxk5s5y%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Christopher,

[auto build test ERROR on net/master -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Christopher-S-Hall/Patchset-enabling-hardware-based-cross-timestamps-for-next-gen-Intel-platforms/20151013-095135
config: x86_64-randconfig-x015-10130227 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   arch/x86/kernel/tsc.c: In function 'convert_art_to_tsc':
>> arch/x86/kernel/tsc.c:1098:18: error: 'art_to_tsc_denominator' undeclared (first use in this function)
     res = (cycles / art_to_tsc_denominator) * art_to_tsc_numerator;
                     ^
   arch/x86/kernel/tsc.c:1098:18: note: each undeclared identifier is reported only once for each function it appears in
>> arch/x86/kernel/tsc.c:1098:44: error: 'art_to_tsc_numerator' undeclared (first use in this function)
     res = (cycles / art_to_tsc_denominator) * art_to_tsc_numerator;
                                               ^

vim +/art_to_tsc_denominator +1098 arch/x86/kernel/tsc.c

  1092	 * Convert ART to TSC given numerator/denominator found in detect_art()
  1093	 */
  1094	static u64 convert_art_to_tsc(struct correlated_cs *cs, u64 cycles)
  1095	{
  1096		u64 tmp, res;
  1097	
> 1098		res = (cycles / art_to_tsc_denominator) * art_to_tsc_numerator;
  1099		tmp = (cycles % art_to_tsc_denominator) * art_to_tsc_numerator;
  1100		res += tmp / art_to_tsc_denominator;
  1101	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 20933 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151013/8db62384/attachment-0001.obj>
