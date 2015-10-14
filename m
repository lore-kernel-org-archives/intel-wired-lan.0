From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 14 Oct 2015 18:03:46 +0000
Subject: [Intel-wired-lan] [next-queue v2 01/17] fm10k: conditionally
 compile DCB and DebugFS support
In-Reply-To: <20151014164235.GA26991@aiaiai.jf.intel.com>
References: <20151014164235.GA26991@aiaiai.jf.intel.com>
Message-ID: <1444845826.26286.31.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2015-10-14 at 09:42 -0700, ND Linux CI Server wrote:
> Bisectability test results for configuration "intel_defconfig,x86"
> 
> Failed to build patch #3: 9800d00 fm10k: reinitialize queuing scheme after calling init_hw
> Configuration: "intel_defconfig, architecture x86".
> 
> 
> drivers/net/ethernet/intel/fm10k/fm10k_pci.c: In function ?fm10k_reinit?:
> drivers/net/ethernet/intel/fm10k/fm10k_pci.c:176:3: error: label ?reinit_err? used but not defined
>    goto reinit_err;
>    ^
> make[6]: *** [drivers/net/ethernet/intel/fm10k/fm10k_pci.o] Error 1
> Failed to build patch #4: ef14b12 fm10k: reset max_queues on init_hw_vf failure
> Configuration: "intel_defconfig, architecture x86".
> 
> 
> drivers/net/ethernet/intel/fm10k/fm10k_pci.c: In function ?fm10k_reinit?:
> drivers/net/ethernet/intel/fm10k/fm10k_pci.c:176:3: error: label ?reinit_err? used but not defined
>    goto reinit_err;
>    ^
> make[6]: *** [drivers/net/ethernet/intel/fm10k/fm10k_pci.o] Error 1

This can be fixed by just re-ordering patch 3 as patch 5, but I can
resend if you don't want to do that by hand. There is no merge conflict
when I did it via interactive rebase.

Regards,
Jake
