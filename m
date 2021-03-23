From: Bjorn Helgaas <helgaas@kernel.org>
Date: Tue, 23 Mar 2021 14:39:23 -0500
Subject: [Intel-wired-lan] [PATCH next-queue v3 3/3] igc: Add support
 for PTP getcrosststamp()
In-Reply-To: <20210322161822.1546454-4-vinicius.gomes@intel.com>
Message-ID: <20210323193923.GA597480@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Mar 22, 2021 at 09:18:22AM -0700, Vinicius Costa Gomes wrote:
> i225 has support for PCIe PTM, which allows us to implement support
> for the PTP_SYS_OFFSET_PRECISE ioctl(), implemented in the driver via
> the getcrosststamp() function.

> +static bool igc_is_ptm_supported(struct igc_adapter *adapter)
> +{
> +#if IS_ENABLED(CONFIG_X86_TSC) && IS_ENABLED(CONFIG_PCIE_PTM)
> +	return adapter->pdev->ptm_enabled;
> +#endif

It's not obvious why you make this x86-specific.  Maybe a comment?

You shouldn't have to test for CONFIG_PCIE_PTM, either.  We probably
should have a pdev->ptm_enabled() predicate with a stub that returns
false when CONFIG_PCIE_PTM is not set.

> +	return false;
> +}

> +/* PCIe Registers */
> +#define IGC_PTM_CTRL		0x12540  /* PTM Control */
> +#define IGC_PTM_STAT		0x12544  /* PTM Status */
> +#define IGC_PTM_CYCLE_CTRL	0x1254C  /* PTM Cycle Control */
> +
> +/* PTM Time registers */
> +#define IGC_PTM_T1_TIM0_L	0x12558  /* T1 on Timer 0 Low */
> +#define IGC_PTM_T1_TIM0_H	0x1255C  /* T1 on Timer 0 High */
> +
> +#define IGC_PTM_CURR_T2_L	0x1258C  /* Current T2 Low */
> +#define IGC_PTM_CURR_T2_H	0x12590  /* Current T2 High */
> +#define IGC_PTM_PREV_T2_L	0x12584  /* Previous T2 Low */
> +#define IGC_PTM_PREV_T2_H	0x12588  /* Previous T2 High */
> +#define IGC_PTM_PREV_T4M1	0x12578  /* T4 Minus T1 on previous PTM Cycle */
> +#define IGC_PTM_CURR_T4M1	0x1257C  /* T4 Minus T1 on this PTM Cycle */
> +#define IGC_PTM_PREV_T3M2	0x12580  /* T3 Minus T2 on previous PTM Cycle */
> +#define IGC_PTM_TDELAY		0x12594  /* PTM PCIe Link Delay */
> +
> +#define IGC_PCIE_DIG_DELAY	0x12550  /* PCIe Digital Delay */
> +#define IGC_PCIE_PHY_DELAY	0x12554  /* PCIe PHY Delay */

I assume the above are device-specific registers, right?  Nothing that
would be found in the PCIe base spec?

Bjorn
