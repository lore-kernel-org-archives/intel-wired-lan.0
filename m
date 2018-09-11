From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 11 Sep 2018 21:46:59 +0000
Subject: [Intel-wired-lan] [PATCH v7 01/11] igc: Add skeletal frame for
 Intel(R) 2.5G Ethernet Controller support.
In-Reply-To: <20180828155946.26270-1-sasha.neftin@intel.com>
References: <20180828155946.26270-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B96558766@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sasha Neftin
> Sent: Tuesday, August 28, 2018 9:00 AM
> To: Neftin, Sasha <sasha.neftin@intel.com>; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v7 01/11] igc: Add skeletal frame for
> Intel(R) 2.5G Ethernet Controller support.
> 
> This patch adds the beginning framework onto which I am going to add
> the igc driver which supports the Intel(R) I225-LM/I225-V 2.5G
> Ethernet Controller.
> 
> Sasha Neftin (v2):
> update module author, copyright and licence header
> cosmetic changes
> 
> Sasha Neftin (v3):
> remove unused header files
> 
> Sasha Neftin (v4):
> update brand name
> fix syntax by input from community
> replace e1000_ prefix with igc_ prefix
> 
> Sasha Neftin (v5):
> no changes
> 
> Sasha Neftin (v6):
> no changes
> 
> Sasha Neftin (v7):
> no changes
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/Kconfig        |  16 ++++
>  drivers/net/ethernet/intel/Makefile       |   1 +
>  drivers/net/ethernet/intel/igc/Makefile   |  10 ++
>  drivers/net/ethernet/intel/igc/igc.h      |  29 ++++++
>  drivers/net/ethernet/intel/igc/igc_hw.h   |  10 ++
>  drivers/net/ethernet/intel/igc/igc_main.c | 146
> ++++++++++++++++++++++++++++++
>  6 files changed, 212 insertions(+)
>  create mode 100644 drivers/net/ethernet/intel/igc/Makefile
>  create mode 100644 drivers/net/ethernet/intel/igc/igc.h
>  create mode 100644 drivers/net/ethernet/intel/igc/igc_hw.h
>  create mode 100644 drivers/net/ethernet/intel/igc/igc_main.c
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
