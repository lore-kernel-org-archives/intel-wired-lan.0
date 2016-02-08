From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 08 Feb 2016 04:08:18 -0800
Subject: [Intel-wired-lan] [next-queue PATCH] fm10k: Avoid crashing the
 kernel
In-Reply-To: <20151222221012.91665.98612.stgit@bwallan-cwp1.jf.intel.com>
References: <20151222221012.91665.98612.stgit@bwallan-cwp1.jf.intel.com>
Message-ID: <1454933298.6172.1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-12-22 at 14:10 -0800, Bruce Allan wrote:
> Use BUILD_BUG_ON() instead of BUG_ON() where appropriate to get a
> compile
> error rather than crash the kernel.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> ---
> ?drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c |??? 4 ++--
> ?1 file changed, 2 insertions(+), 2 deletions(-)

Dropping this patch because it now causes a compile issue with my next-
queue tree (dev-queue branch), here is the compile errors recieved:

[04:04:54 @jtkirshe-linux:next-queue]$ make -j 77 -s
In file included from include/linux/linkage.h:4:0,
?????????????????from include/linux/preempt.h:9,
?????????????????from include/linux/spinlock.h:50,
?????????????????from include/linux/vmalloc.h:4,
?????????????????from
drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c:21:
drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c: In function
?fm10k_get_reg_vsi?:
include/linux/compiler.h:501:38: error: call to
?__compiletime_assert_487? declared with attribute error: BUILD_BUG_ON
failed: idx != FM10K_REGS_LEN_VSI
? _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
??????????????????????????????????????^
include/linux/compiler.h:484:4: note: in definition of macro
?__compiletime_assert?
????prefix ## suffix();????\
????^
include/linux/compiler.h:501:2: note: in expansion of macro
?_compiletime_assert?
? _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
? ^
include/linux/bug.h:50:37: note: in expansion of macro
?compiletime_assert?
?#define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
?????????????????????????????????????^
include/linux/bug.h:74:2: note: in expansion of macro
?BUILD_BUG_ON_MSG?
? BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
? ^
drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c:487:2: note: in
expansion of macro ?BUILD_BUG_ON?
? BUILD_BUG_ON(idx != FM10K_REGS_LEN_VSI);
? ^
scripts/Makefile.build:258: recipe for target
'drivers/net/ethernet/intel/fm10k/fm10k_ethtool.o' failed
make[5]: *** [drivers/net/ethernet/intel/fm10k/fm10k_ethtool.o] Error 1
make[5]: *** Waiting for unfinished jobs....
scripts/Makefile.build:407: recipe for target
'drivers/net/ethernet/intel/fm10k' failed
make[4]: *** [drivers/net/ethernet/intel/fm10k] Error 2
make[4]: *** Waiting for unfinished jobs....
scripts/Makefile.build:407: recipe for target
'drivers/net/ethernet/intel' failed
make[3]: *** [drivers/net/ethernet/intel] Error 2
scripts/Makefile.build:407: recipe for target 'drivers/net/ethernet'
failed
make[2]: *** [drivers/net/ethernet] Error 2
scripts/Makefile.build:407: recipe for target 'drivers/net' failed
make[1]: *** [drivers/net] Error 2
Makefile:950: recipe for target 'drivers' failed
make: *** [drivers] Error 2
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160208/76dbb2ac/attachment.asc>
