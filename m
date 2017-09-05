From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 5 Sep 2017 21:59:48 +0000
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 84/87]
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4165:14: error: call to
 '__cmpxchg_wrong_size' declared with attribute error: Bad argument size for
 cmpxchg
In-Reply-To: <201709020913.pcw87O2v%fengguang.wu@intel.com>
References: <201709020913.pcw87O2v%fengguang.wu@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB5882A9B093@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Wu, Fengguang
> Sent: Friday, September 01, 2017 6:41 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: kbuild-all at 01.org; intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; Williams, Mitch A <mitch.a.williams@intel.com>
> Subject: [jkirsher-next-queue:dev-queue 84/87]
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4165:14: error: call to
> '__cmpxchg_wrong_size' declared with attribute error: Bad argument size for
> cmpxchg
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-
> queue
> head:   08f91a425600cdae9ff6637b7619ef6e25aa3938
> commit: 49f85995faccb903cf9256208c9caa7cb2decaf7 [84/87] i40e/i40evf:
> organize and re-number feature flags
> config: i386-allyesconfig (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         git checkout 49f85995faccb903cf9256208c9caa7cb2decaf7
>         # save the attached .config to linux build tree
>         make ARCH=i386
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/net/ethernet/intel/i40e/i40e_ethtool.c: In function 'i40e_set_priv_flags':
>    drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4155:5: warning: '__ret' may be
> used uninitialized in this function [-Wmaybe-uninitialized]
>      if (cmpxchg(&pf->flags, orig_flags, new_flags) != orig_flags) {
>         ^
> >> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4165:14: error: call to
> '__cmpxchg_wrong_size' declared with attribute error: Bad argument size for
> cmpxchg
>       * changed in the code above.
>                  ^~~~~~~~~~~~~~~~~
> 

I'm not sure what this means exactly..? I'm guessing it's generating a warning because of using the wrong size of variables, but I thought cmpxchg took 32byte data, which all those flags variables are now.

Thanks,
Jake
