From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 11 Sep 2019 21:36:47 +0000
Subject: [Intel-wired-lan] [PATCH net 2/2] igb: Fix constant media auto
 sense switching when no cable is connected.
In-Reply-To: <20190815205520.22475-2-jeffrey.t.kirsher@intel.com>
References: <20190815205520.22475-1-jeffrey.t.kirsher@intel.com>
 <20190815205520.22475-2-jeffrey.t.kirsher@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B971174D4@ORSMSX103.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH net 2/2] igb: Fix constant media auto sense
> switching when no cable is connected.
> 
> From: Manfred Rudigier <manfred.rudigier@omicronenergy.com>
> 
> At least on the i350 there is an annoying behavior that is maybe also
> present on 82580 devices, but was probably not noticed yet as MAS is not
> widely used.
> 
> If no cable is connected on both fiber/copper ports the media auto sense
> code will constantly swap between them as part of the watchdog task and
> produce many unnecessary kernel log messages.
> 
> The swap code responsible for this behavior (switching to fiber) should
> not be executed if the current media type is copper and there is no signal
> detected on the fiber port. In this case we can safely wait until the
> AUTOSENSE_EN bit is cleared.
> 
> Signed-off-by: Manfred Rudigier <manfred.rudigier@omicronenergy.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
