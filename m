From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 8 May 2020 18:11:33 +0000
Subject: [Intel-wired-lan] [PATCH v5] igc: add support to eeprom,
 registers and link self-tests
In-Reply-To: <20200505140638.44937-1-vitaly.lifshits@intel.com>
References: <20200505140638.44937-1-vitaly.lifshits@intel.com>
Message-ID: <DM6PR11MB289041C1D48B674A3C59B1B1BCA20@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Vitaly Lifshits
> Sent: Tuesday, May 5, 2020 7:07 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v5] igc: add support to eeprom, registers
> and link self-tests
> 
> Introduced igc_diag.c and igc_diag.h, these files have the
> diagnostics functionality of igc driver. For the time being
> these files are being used by ethtool self-test callbacks.
> Which mean that eeprom, registers and link self-tests for
> ethtool were implemented.
> 
> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: Fix return 0/1 to boolean value in igc_reg_test function
> v3: Address community comments
> v4: Fix interrupt test and address community comments
> v5: Remove interrupt test in order to avoid kernel panic
> ---
>  drivers/net/ethernet/intel/igc/Makefile      |   2 +-
>  drivers/net/ethernet/intel/igc/igc.h         |   4 +
>  drivers/net/ethernet/intel/igc/igc_diag.c    | 186
> +++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_diag.h    |  30 +++++
>  drivers/net/ethernet/intel/igc/igc_ethtool.c |  60 +++++++++
>  drivers/net/ethernet/intel/igc/igc_main.c    |   4 +-
>  drivers/net/ethernet/intel/igc/igc_regs.h    |   2 +
>  7 files changed, 285 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/net/ethernet/intel/igc/igc_diag.c
>  create mode 100644 drivers/net/ethernet/intel/igc/igc_diag.h
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
