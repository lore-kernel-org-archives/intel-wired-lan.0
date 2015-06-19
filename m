From: Sullivan, Catherine <catherine.sullivan@intel.com>
Date: Fri, 19 Jun 2015 18:24:41 +0000
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 81/82]
 drivers/net/ethernet/intel/i40e/i40e_txrx.c:2043:18: error:
 'I40E_FLAG_HW_ATR_EVICT_CAPABLE' undeclared
In-Reply-To: <201506120839.6uPiTzuq%fengguang.wu@intel.com>
References: <201506120839.6uPiTzuq%fengguang.wu@intel.com>
Message-ID: <E8A77B2FB54C194393A5C2A8E3ED16782666BB13@CRSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I cannot reproduce this error with the given config file. The tree has been rebased since the error was reported and I can no longer checkout the commit ID given but the version of the patch on the tree does not have this error.

> -----Original Message-----
> From: Wu, Fengguang
> Sent: Thursday, June 11, 2015 5:28 PM
> To: Singhai, Anjali
> Cc: kbuild-all at 01.org; Kirsher, Jeffrey T; Sullivan, Catherine; intel-wired-
> lan at lists.osuosl.org
> Subject: [jkirsher-next-queue:dev-queue 81/82]
> drivers/net/ethernet/intel/i40e/i40e_txrx.c:2043:18: error:
> 'I40E_FLAG_HW_ATR_EVICT_CAPABLE' undeclared
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
> dev-queue
> head:   a77608e2c8d74ca16cf2738a9d2e9d90f9499c24
> commit: 6a9cd2f4c6f450a47bbaa9f4db0d803f9143c6d8 [81/82] i40e/i40evf:
> Add ATR HW eviction support for X722
> config: i386-randconfig-r0-201523 (attached as .config)
> reproduce:
>   git checkout 6a9cd2f4c6f450a47bbaa9f4db0d803f9143c6d8
>   # save the attached .config to linux build tree
>   make ARCH=i386
> 
> All error/warnings (new ones prefixed by >>):
> 
>    drivers/net/ethernet/intel/i40e/i40e_txrx.c: In function 'i40e_rx_checksum':
>    drivers/net/ethernet/intel/i40e/i40e_txrx.c:1432:27: error:
> 'I40E_FLAG_OUTER_UDP_CSUM_CAPABLE' undeclared (first use in this
> function)
>      if (!(vsi->back->flags & I40E_FLAG_OUTER_UDP_CSUM_CAPABLE) &&
>                               ^
>    drivers/net/ethernet/intel/i40e/i40e_txrx.c:1432:27: note: each undeclared
> identifier is reported only once for each function it appears in
>    drivers/net/ethernet/intel/i40e/i40e_txrx.c: In function 'i40e_atr':
> >> drivers/net/ethernet/intel/i40e/i40e_txrx.c:2043:18: error:
> 'I40E_FLAG_HW_ATR_EVICT_CAPABLE' undeclared (first use in this function)
>      if (pf->flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE) {
>                      ^
> 
> vim +/I40E_FLAG_HW_ATR_EVICT_CAPABLE +2043
> drivers/net/ethernet/intel/i40e/i40e_txrx.c
> 
>   2037
>   2038		th = (struct tcphdr *)(hdr.network + hlen);
>   2039
>   2040		/* Due to lack of space, no more new filters can be
> programmed */
>   2041		if (th->syn && (pf->auto_disable_flags &
> I40E_FLAG_FD_ATR_ENABLED))
>   2042			return;
> > 2043		if (pf->flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE) {
>   2044			/* HW ATR eviction will take care of removing filters
> on FIN
>   2045			 * and RST packets.
>   2046			 */
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
