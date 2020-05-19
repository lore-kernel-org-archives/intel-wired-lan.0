From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Tue, 19 May 2020 18:20:09 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next v3 07/15] i40e: separate
 kernel allocated rx_bi rings from AF_XDP rings
In-Reply-To: <202005192351.j1H08VpV%lkp@intel.com>
References: <20200519085724.294949-8-bjorn.topel@gmail.com>
 <202005192351.j1H08VpV%lkp@intel.com>
Message-ID: <c81b36a0-11dd-4b7f-fad8-85f31dced58c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2020-05-19 17:18, kbuild test robot wrote:
> Hi "Bj?rn,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on bpf-next/master]
> [also build test WARNING on jkirsher-next-queue/dev-queue next-20200518]
> [cannot apply to bpf/master linus/master v5.7-rc6]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Bj-rn-T-pel/Introduce-AF_XDP-buffer-allocation-API/20200519-203122
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> config: riscv-allyesconfig (attached as .config)
> compiler: riscv64-linux-gcc (GCC) 9.3.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=riscv
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
>>> drivers/net/ethernet/intel/i40e/i40e_txrx.c:531:6: warning: no previous prototype for 'i40e_fd_handle_status' [-Wmissing-prototypes]
> 531 | void i40e_fd_handle_status(struct i40e_ring *rx_ring, u64 qword0_raw,
> |      ^~~~~~~~~~~~~~~~~~~~~
>

Yes, this could indeed be made static. Hmm, I wonder why I didn't get
that warning on my x86-64 build!? I'll spin a v4 (or do a follow-up?).


Bj?rn
