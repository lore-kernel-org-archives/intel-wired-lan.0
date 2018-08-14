From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Tue, 14 Aug 2018 11:55:55 -0700
Subject: [Intel-wired-lan] [PATCH next-queue 3/8] ixgbe: add VF ipsec
 management
In-Reply-To: <201808141311.4srvjTmi%fengguang.wu@intel.com>
References: <1534185825-12451-4-git-send-email-shannon.nelson@oracle.com>
 <201808141311.4srvjTmi%fengguang.wu@intel.com>
Message-ID: <c094b08d-1cf5-6ab5-4314-f2ba519fc956@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/13/2018 10:31 PM, kbuild test robot wrote:
> Hi Shannon,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on jkirsher-next-queue/dev-queue]
> [also build test ERROR on v4.18 next-20180813]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Shannon-Nelson/ixgbe-ixgbevf-IPsec-offload-support-for-VFs/20180814-074800
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
> config: x86_64-randconfig-v0-08131550 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=x86_64
> 
> All errors (new ones prefixed by >>):
> 
>     drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.o: In function `ixgbe_ipsec_vf_add_sa':
>>> drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:917: undefined reference to `xfrm_aead_get_byname'
>     make[1]: *** [vmlinux] Error 1
>     make[1]: Target '_all' not remade because of errors.
> 

Huh, odd.  I'm not able to reproduce this error using your config file 
in a net-next tree of vintage v4.18-rc8 or in Jeff's dev-queue branch. 
It looks like I'm using an older compiler (4.8.5) but that shouldn't 
make a difference here.

sln

