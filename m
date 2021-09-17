From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 17 Sep 2021 14:57:01 -0700
Subject: [Intel-wired-lan] [PATCH -net] igc: fix build errors for PTP
In-Reply-To: <20210917210547.12578-1-rdunlap@infradead.org>
References: <20210917210547.12578-1-rdunlap@infradead.org>
Message-ID: <8735q2yifm.fsf@vcostago-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Randy Dunlap <rdunlap@infradead.org> writes:

> When IGC=y and PTP_1588_CLOCK=m, the ptp_*() interface family is
> not available to the igc driver. Make this driver depend on
> PTP_1588_CLOCK_OPTIONAL so that it will build without errors.
>
> Various igc commits have used ptp_*() functions without checking
> that PTP_1588_CLOCK is enabled. Fix all of these here.
>
> Fixes these build errors:
>
> ld: drivers/net/ethernet/intel/igc/igc_main.o: in function `igc_msix_other':
> igc_main.c:(.text+0x6494): undefined reference to `ptp_clock_event'
> ld: igc_main.c:(.text+0x64ef): undefined reference to `ptp_clock_event'
> ld: igc_main.c:(.text+0x6559): undefined reference to `ptp_clock_event'
> ld: drivers/net/ethernet/intel/igc/igc_ethtool.o: in function `igc_ethtool_get_ts_info':
> igc_ethtool.c:(.text+0xc7a): undefined reference to `ptp_clock_index'
> ld: drivers/net/ethernet/intel/igc/igc_ptp.o: in function `igc_ptp_feature_enable_i225':
> igc_ptp.c:(.text+0x330): undefined reference to `ptp_find_pin'
> ld: igc_ptp.c:(.text+0x36f): undefined reference to `ptp_find_pin'
> ld: drivers/net/ethernet/intel/igc/igc_ptp.o: in function `igc_ptp_init':
> igc_ptp.c:(.text+0x11cd): undefined reference to `ptp_clock_register'
> ld: drivers/net/ethernet/intel/igc/igc_ptp.o: in function `igc_ptp_stop':
> igc_ptp.c:(.text+0x12dd): undefined reference to `ptp_clock_unregister'
> ld: drivers/platform/x86/dell/dell-wmi-privacy.o: in function `dell_privacy_wmi_probe':
>
> Fixes: 64433e5bf40ab ("igc: Enable internal i225 PPS")
> Fixes: 60dbede0c4f3d ("igc: Add support for ethtool GET_TS_INFO command")
> Fixes: 87938851b6efb ("igc: enable auxiliary PHC functions for the i225")
> Fixes: 5f2958052c582 ("igc: Add basic skeleton for PTP")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Ederson de Souza <ederson.desouza@intel.com>
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org
> ---

Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>


-- 
Vinicius
