From: Rustad, Mark D <mark.d.rustad@intel.com>
Date: Tue, 29 Sep 2015 16:29:21 +0000
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 32/134]
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:129:12: warning:
 'ixgbe_get_cs4227_status' defined but not used
In-Reply-To: <201509291454.fGmMdfRo%fengguang.wu@intel.com>
References: <201509291454.fGmMdfRo%fengguang.wu@intel.com>
Message-ID: <4CD378B1-8EE8-46CA-A733-68CB5B73E750@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On Sep 28, 2015, at 11:20 PM, Wu, Fengguang <fengguang.wu@intel.com> wrote:
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
> head:   c92a893286c9df9eccaa72cb355a78e2de47f006
> commit: 06add52056ace8ff659f6f442488bb46f83736a8 [32/134] ixgbe: Remove CS4227 diagnostic code
> config: powerpc-defconfig (attached as .config)
> reproduce:
>  wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>  chmod +x ~/bin/make.cross
>  git checkout 06add52056ace8ff659f6f442488bb46f83736a8
>  # save the attached .config to linux build tree
>  make.cross ARCH=powerpc
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:129:12: warning: 'ixgbe_get_cs4227_status' defined but not used [-Wunused-function]
>    static s32 ixgbe_get_cs4227_status(struct ixgbe_hw *hw)
>               ^

In my repo this code is deleted by the patch "ixgbe: Remove CS4227 diagnostic code". It almost seems like part of that patch got dropped or something.

--
Mark Rustad, Networking Division, Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 841 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150929/021cdad5/attachment.asc>
