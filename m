From: kbuild test robot <lkp@intel.com>
Date: Tue, 19 May 2020 23:18:58 +0800
Subject: [Intel-wired-lan] [PATCH bpf-next v3 07/15] i40e: separate
 kernel allocated rx_bi rings from AF_XDP rings
In-Reply-To: <20200519085724.294949-8-bjorn.topel@gmail.com>
References: <20200519085724.294949-8-bjorn.topel@gmail.com>
Message-ID: <202005192351.j1H08VpV%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi "Bj?rn,

I love your patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]
[also build test WARNING on jkirsher-next-queue/dev-queue next-20200518]
[cannot apply to bpf/master linus/master v5.7-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Bj-rn-T-pel/Introduce-AF_XDP-buffer-allocation-API/20200519-203122
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: riscv-allyesconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> drivers/net/ethernet/intel/i40e/i40e_txrx.c:531:6: warning: no previous prototype for 'i40e_fd_handle_status' [-Wmissing-prototypes]
531 | void i40e_fd_handle_status(struct i40e_ring *rx_ring, u64 qword0_raw,
|      ^~~~~~~~~~~~~~~~~~~~~

vim +/i40e_fd_handle_status +531 drivers/net/ethernet/intel/i40e/i40e_txrx.c

   520	
   521	/**
   522	 * i40e_fd_handle_status - check the Programming Status for FD
   523	 * @rx_ring: the Rx ring for this descriptor
   524	 * @qword0_raw: qword0
   525	 * @qword1: qword1 after le_to_cpu
   526	 * @prog_id: the id originally used for programming
   527	 *
   528	 * This is used to verify if the FD programming or invalidation
   529	 * requested by SW to the HW is successful or not and take actions accordingly.
   530	 **/
 > 531	void i40e_fd_handle_status(struct i40e_ring *rx_ring, u64 qword0_raw,
   532				   u64 qword1, u8 prog_id)
   533	{
   534		struct i40e_pf *pf = rx_ring->vsi->back;
   535		struct pci_dev *pdev = pf->pdev;
   536		struct i40e_32b_rx_wb_qw0 *qw0;
   537		u32 fcnt_prog, fcnt_avail;
   538		u32 error;
   539	
   540		qw0 = (struct i40e_32b_rx_wb_qw0 *)&qword0_raw;
   541		error = (qword1 & I40E_RX_PROG_STATUS_DESC_QW1_ERROR_MASK) >>
   542			I40E_RX_PROG_STATUS_DESC_QW1_ERROR_SHIFT;
   543	
   544		if (error == BIT(I40E_RX_PROG_STATUS_DESC_FD_TBL_FULL_SHIFT)) {
   545			pf->fd_inv = le32_to_cpu(qw0->hi_dword.fd_id);
   546			if (qw0->hi_dword.fd_id != 0 ||
   547			    (I40E_DEBUG_FD & pf->hw.debug_mask))
   548				dev_warn(&pdev->dev, "ntuple filter loc = %d, could not be added\n",
   549					 pf->fd_inv);
   550	
   551			/* Check if the programming error is for ATR.
   552			 * If so, auto disable ATR and set a state for
   553			 * flush in progress. Next time we come here if flush is in
   554			 * progress do nothing, once flush is complete the state will
   555			 * be cleared.
   556			 */
   557			if (test_bit(__I40E_FD_FLUSH_REQUESTED, pf->state))
   558				return;
   559	
   560			pf->fd_add_err++;
   561			/* store the current atr filter count */
   562			pf->fd_atr_cnt = i40e_get_current_atr_cnt(pf);
   563	
   564			if (qw0->hi_dword.fd_id == 0 &&
   565			    test_bit(__I40E_FD_SB_AUTO_DISABLED, pf->state)) {
   566				/* These set_bit() calls aren't atomic with the
   567				 * test_bit() here, but worse case we potentially
   568				 * disable ATR and queue a flush right after SB
   569				 * support is re-enabled. That shouldn't cause an
   570				 * issue in practice
   571				 */
   572				set_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state);
   573				set_bit(__I40E_FD_FLUSH_REQUESTED, pf->state);
   574			}
   575	
   576			/* filter programming failed most likely due to table full */
   577			fcnt_prog = i40e_get_global_fd_count(pf);
   578			fcnt_avail = pf->fdir_pf_filter_count;
   579			/* If ATR is running fcnt_prog can quickly change,
   580			 * if we are very close to full, it makes sense to disable
   581			 * FD ATR/SB and then re-enable it when there is room.
   582			 */
   583			if (fcnt_prog >= (fcnt_avail - I40E_FDIR_BUFFER_FULL_MARGIN)) {
   584				if ((pf->flags & I40E_FLAG_FD_SB_ENABLED) &&
   585				    !test_and_set_bit(__I40E_FD_SB_AUTO_DISABLED,
   586						      pf->state))
   587					if (I40E_DEBUG_FD & pf->hw.debug_mask)
   588						dev_warn(&pdev->dev, "FD filter space full, new ntuple rules will not be added\n");
   589			}
   590		} else if (error == BIT(I40E_RX_PROG_STATUS_DESC_NO_FD_ENTRY_SHIFT)) {
   591			if (I40E_DEBUG_FD & pf->hw.debug_mask)
   592				dev_info(&pdev->dev, "ntuple filter fd_id = %d, could not be removed\n",
   593					 qw0->hi_dword.fd_id);
   594		}
   595	}
   596	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63439 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200519/3d0ec82b/attachment-0001.bin>
