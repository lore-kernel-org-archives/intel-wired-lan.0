From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 11 Sep 2019 21:36:30 +0000
Subject: [Intel-wired-lan] [PATCH net 1/2] igb: Enable media autosense
 for the i350.
In-Reply-To: <20190815205520.22475-1-jeffrey.t.kirsher@intel.com>
References: <20190815205520.22475-1-jeffrey.t.kirsher@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B971174BC@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Thursday, August 15, 2019 1:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Manfred Rudigier <manfred.rudigier@omicronenergy.com>
> Subject: [Intel-wired-lan] [PATCH net 1/2] igb: Enable media autosense for
> the i350.
> 
> From: Manfred Rudigier <manfred.rudigier@omicronenergy.com>
> 
> This patch enables the hardware feature "Media Auto Sense" also on the
> i350. It works in the same way as on the 82850 devices. Hardware designs
> using dual PHYs (fiber/copper) can enable this feature by setting the MAS
> enable bits in the NVM_COMPAT register (0x03) in the EEPROM.
> 
> Signed-off-by: Manfred Rudigier <manfred.rudigier@omicronenergy.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_82575.c | 2 +-
>  drivers/net/ethernet/intel/igb/igb_main.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
