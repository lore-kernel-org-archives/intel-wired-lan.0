From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Thu, 4 May 2017 23:29:50 +0000
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue 4/4]
 drivers/net/ethernet/intel/i40e/i40e_main.c:8828:16: error:
 'I40E_FLAG_HW_ATR_EVICT_ENABLED' undeclared
In-Reply-To: <201705050505.wALUZ7vS%fengguang.wu@intel.com>
References: <201705050505.wALUZ7vS%fengguang.wu@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB5857E20FD5@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Wu, Fengguang
> Sent: Thursday, May 04, 2017 2:55 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: kbuild-all at 01.org; intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [jkirsher-net-queue:dev-queue 4/4]
> drivers/net/ethernet/intel/i40e/i40e_main.c:8828:16: error:
> 'I40E_FLAG_HW_ATR_EVICT_ENABLED' undeclared
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git
> dev-queue
> head:   9714e5c2be7ebfe681a124c9cfca810eedb6bb4c
> commit: 9714e5c2be7ebfe681a124c9cfca810eedb6bb4c [4/4] i40e: fix incorrect
> assignment of I40E_FLAG_HW_ATR_EVICT_CAPABLE
> config: x86_64-rhel (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         git checkout 9714e5c2be7ebfe681a124c9cfca810eedb6bb4c
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_sw_init':
> >> drivers/net/ethernet/intel/i40e/i40e_main.c:8828:16: error:
> 'I40E_FLAG_HW_ATR_EVICT_ENABLED' undeclared (first use in this function)
>       pf->flags |= I40E_FLAG_HW_ATR_EVICT_ENABLED;
>                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/net/ethernet/intel/i40e/i40e_main.c:8828:16: note: each undeclared
> identifier is reported only once for each function it appears in
> 
> vim +/I40E_FLAG_HW_ATR_EVICT_ENABLED +8828
> drivers/net/ethernet/intel/i40e/i40e_main.c
> 
>   8822			/* Supported in FW API version higher than 1.4 */
>   8823			pf->flags |= I40E_FLAG_GENEVE_OFFLOAD_CAPABLE;
>   8824		}
>   8825
>   8826		/* Enable HW ATR eviction if possible */
>   8827		if (pf->flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE)
> > 8828			pf->flags |= I40E_FLAG_HW_ATR_EVICT_ENABLED;
>   8829
>   8830		pf->eeprom_version = 0xDEAD;
>   8831		pf->lan_veb = I40E_NO_VEB;
> 

Yep, this was already fixed, sorry I had my trees mixed up and I thought a patch was already applied when it wasn't, so what I sent was wrong. I've fixed this up now.

Thanks,
Jake
