From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 9 Apr 2019 21:57:29 +0000
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 91/93] ERROR:
 "__udivdi3" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
In-Reply-To: <201904100404.991wuqNy%lkp@intel.com>
References: <201904100404.991wuqNy%lkp@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB5892351100@ORSMSX121.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: lkp
> Sent: Tuesday, April 09, 2019 1:33 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: kbuild-all at 01.org; intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [jkirsher-next-queue:dev-queue 91/93] ERROR: "__udivdi3"
> [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-
> queue
> head:   7d150c75aed54f069f2bac6385ef3ffe8f6b8ddf
> commit: e5ce07e126190433f802dffacf5013dc19f8c1e5 [91/93] ixgbe: implement
> support for SDP/PPS output on X550 hardware
> config: i386-randconfig-i1-201914 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout e5ce07e126190433f802dffacf5013dc19f8c1e5
>         # save the attached .config to linux build tree
>         make ARCH=i386
> 
> All errors (new ones prefixed by >>):
> 
> >> ERROR: "__udivdi3" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

I'm guessing this is due to calls to div_u64_rem and div_u64?

Regards,
Jake
