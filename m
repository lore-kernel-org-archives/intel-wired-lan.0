From: Andre Guedes <andre.guedes@linux.intel.com>
Date: Tue, 24 Mar 2020 17:17:21 -0700
Subject: [Intel-wired-lan] [PATCH v3] igc: add support to interrupt,
 eeprom, registers and link self-tests
In-Reply-To: <20200322184909.19122-1-vitaly.lifshits@intel.com>
References: <20200322184909.19122-1-vitaly.lifshits@intel.com>
Message-ID: <158509544149.2475.17714180585378673278@johnorte-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Vitaly,

Quoting Vitaly Lifshits (2020-03-22 11:49:09)
> Introduced igc_diag.c and igc_diag.h, these files have the
> diagnostics functionality of igc driver. For the time being
> these files are being used by ethtool self-test callbacks.
> Which mean that interrupt, eeprom, registers and link self-tests for
> ethtool were implemented.
> 
> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> ---
> v2: Fix return 0/1 to boolean value in igc_reg_test function
> v3: Address community comments

When I run the offline tests, the interrupt test fails:

$ sudo ethtool -t enp2s0 offline
The test result is FAIL
The test extra info:
Register test  (offline)         0
Eeprom test    (offline)         0
Interrupt test (offline)         4
Loopback test  (offline)         0
Link test   (on/offline)         0

Is this expected?

> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index 4823b8ead547..1685609cd15f 100644
...
> +enum igc_ethtool_test_id {
> +       IGC_ETH_TEST_REG = 0,
> +       IGC_ETH_TEST_EEPROM,
> +       IGC_ETH_TEST_INTR,
> +       IGC_ETH_TEST_LOOP,
> +       IGC_ETH_TEST_LINK,
> +};

I seems this enum is only used in igc_ethtool.c so how about we defined it
there intead of in igc.h?

> diff --git a/drivers/net/ethernet/intel/igc/igc_diag.c b/drivers/net/ethernet/intel/igc/igc_diag.c
> new file mode 100644
> index 000000000000..56acc9b8447e
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/igc/igc_diag.c
> @@ -0,0 +1,326 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c)  2018 Intel Corporation */

s/2018/2020/

> diff --git a/drivers/net/ethernet/intel/igc/igc_diag.h b/drivers/net/ethernet/intel/igc/igc_diag.h
> new file mode 100644
> index 000000000000..aa5a474d9bb4
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/igc/igc_diag.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c)  2018 Intel Corporation */

s/2018/2020/

> +bool igc_reg_test(struct igc_adapter *adapter, u64 *data);
> +bool igc_eeprom_test(struct igc_adapter *adapter, u64 *data);
> +int igc_intr_test(struct igc_adapter *adapter, u64 *data);
> +u64 igc_link_test(struct igc_adapter *adapter, u64 *data);

These APIs return different types (bool, int, u64)? They all could return bool,
making them more consistent and easier to read.

> +struct igc_reg_test {
> +       u16 reg;
> +       u8 array_len;
> +       u8 test_type;
> +       u32 mask;
> +       u32 write;
> +};

It seems this struct is used only in igc_diag.c, so how about we define it
there instead of here?

> +/* In the hardware, registers are laid out either singly, in arrays
> + * spaced 0x40 bytes apart, or in contiguous tables.  We assume
> + * most tests take place on arrays or single registers (handled
> + * as a single-element array) and special-case the tables.
> + * Table tests are always pattern tests.
> + *
> + * We also make provision for some required setup steps by specifying
> + * registers to be written without any read-back testing.
> + */
> +
> +#define PATTERN_TEST   1
> +#define SET_READ_TEST  2
> +#define TABLE32_TEST   3
> +#define TABLE64_TEST_LO        4
> +#define TABLE64_TEST_HI        5

The comment above applies to these macros here as well.

> +
> +#define ETH_REG_TEST   0
> +#define ETH_EEPROM_TEST        1
> +#define ETH_INTR_TEST  2
> +#define ETH_LOOP_TEST  3
> +#define ETH_LINK_TEST  4

None of the macros above are used in this patch.

Regards,

Andre
