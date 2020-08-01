From: Florian Westphal <fw@strlen.de>
Date: Sat, 1 Aug 2020 16:41:02 +0200
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 1901/1959]
 include/linux/kernel.h:47:38: warning: division by zero
In-Reply-To: <202008012237.F1NJb2jD%lkp@intel.com>
References: <202008012237.F1NJb2jD%lkp@intel.com>
Message-ID: <20200801144102.GI5271@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

kernel test robot <lkp@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
> head:   9217a41c8ac7e1ca23399f9af7455f1085df9594
> commit: 9466a1ccebbe54ac57fb8a89c2b4b854826546a8 [1901/1959] mptcp: enable JOIN requests even if cookies are in use
> config: parisc-randconfig-c004-20200731 (attached as .config)
> compiler: hppa-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 9466a1ccebbe54ac57fb8a89c2b4b854826546a8
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=parisc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/skbuff.h:13,
>                     from net/mptcp/syncookies.c:2:
>    net/mptcp/syncookies.c: In function 'mptcp_join_cookie_init':
> >> include/linux/kernel.h:47:38: warning: division by zero [-Wdiv-by-zero]
>       47 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))

I forgot ARRAY_SIZE can't be used for spinlock_t arrays because they are
0 on UP.  I've sumitted a build fix.
