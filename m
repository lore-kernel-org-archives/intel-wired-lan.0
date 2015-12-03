From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 3 Dec 2015 03:14:59 +0000
Subject: [Intel-wired-lan] [Next PATCH] igb: use the correct
	i210	register for EEMNGCTL
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B81E25EF3@ORSMSX101.amr.corp.intel.com>
References: <309B89C4C689E141A5FF6A0C5FB2118B81E25EF3@ORSMSX101.amr.corp.intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E25F1C@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Todd Fujinaka <todd.fujinaka@intel.com>
>
> The i210 has two EEPROM access registers that are located in
> non-standard offsets: EEARBC and EEMNGCTL. EEARBC was fixed previously
> and EEMNGCTL should also be corrected.
>
> Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
> Reported-by: "Hodek, Roman" <roman.aud@siemens.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_82575.c |    1 +
>  drivers/net/ethernet/intel/igb/e1000_i210.c  |   27 ++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/igb/e1000_i210.h  |    1 +
>  drivers/net/ethernet/intel/igb/e1000_regs.h  |    1 +
>  4 files changed, 30 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
