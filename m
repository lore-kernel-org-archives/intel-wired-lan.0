From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Mon, 14 Jun 2021 17:15:20 +0000
Subject: [Intel-wired-lan] [PATCH] ice: add support for auxiliary
 input/output pins
In-Reply-To: <20210609202937.1135836-1-jacob.e.keller@intel.com>
References: <20210609202937.1135836-1-jacob.e.keller@intel.com>
Message-ID: <81762743e833402ca3c959050862cbdbacf47e86.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2021-06-09 at 13:29 -0700, Jacob Keller wrote:
> From: Maciej Machnikowski <maciej.machnikowski@intel.com>
> 
> The E810 device supports programmable pins for enabling both input
> and
> output events related to the PTP hardware clock. This includes both
> output signals with programmable period, as well as timestamping of
> events on input pins.
> 
> Add support for enabling these using the CONFIG_PTP_1588_CLOCK
> interface.
> 
> This allows programming the software defined pins to take advantage
> of
> the hardware clock features.
> 
> Signed-off-by: Maciej Machnikowski <maciej.machnikowski@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

I'm seeing this for a 32bit build:

> make[2]: *** Deleting file 'modules-only.symvers'
> ERROR: modpost: "__udivdi3" [drivers/net/ethernet/intel/ice/ice.ko]
undefined!
> ERROR: modpost: "__umoddi3" [drivers/net/ethernet/intel/ice/ice.ko]
undefined!
> make[2]: *** [../scripts/Makefile.modpost:150: modules-only.symvers]
Error 1
> make[1]: *** [/next-queue/Makefile:1754: modules] Error 2
> make: *** [Makefile:215: __sub-make] Error 2

