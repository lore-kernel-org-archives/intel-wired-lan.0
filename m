From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Tue, 15 Jun 2021 08:13:25 +0000
Subject: [Intel-wired-lan] [PATCH] ice: add support for auxiliary
 input/output pins
In-Reply-To: <0871761b-d2bd-4d98-b4c6-0779a19d62cf@intel.com>
References: <20210609202937.1135836-1-jacob.e.keller@intel.com>
 <81762743e833402ca3c959050862cbdbacf47e86.camel@intel.com>
 <0871761b-d2bd-4d98-b4c6-0779a19d62cf@intel.com>
Message-ID: <PH0PR11MB495168C6A9DBB0429FEBC82DEA309@PH0PR11MB4951.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Keller, Jacob E <jacob.e.keller@intel.com>
> Sent: Monday, June 14, 2021 7:26 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Subject: Re: [PATCH] ice: add support for auxiliary input/output pins
> 
> 
> 
> On 6/14/2021 10:15 AM, Nguyen, Anthony L wrote:
> > On Wed, 2021-06-09 at 13:29 -0700, Jacob Keller wrote:
> >> From: Maciej Machnikowski <maciej.machnikowski@intel.com>
> >>
> >> The E810 device supports programmable pins for enabling both input
> >> and
> >> output events related to the PTP hardware clock. This includes both
> >> output signals with programmable period, as well as timestamping of
> >> events on input pins.
> >>
> >> Add support for enabling these using the CONFIG_PTP_1588_CLOCK
> >> interface.
> >>
> >> This allows programming the software defined pins to take advantage
> >> of
> >> the hardware clock features.
> >>
> >> Signed-off-by: Maciej Machnikowski <maciej.machnikowski@intel.com>
> >> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> >> ---
> >
> > I'm seeing this for a 32bit build:
> >
> >> make[2]: *** Deleting file 'modules-only.symvers'
> >> ERROR: modpost: "__udivdi3" [drivers/net/ethernet/intel/ice/ice.ko]
> > undefined!
> >> ERROR: modpost: "__umoddi3" [drivers/net/ethernet/intel/ice/ice.ko]
> > undefined!
> >> make[2]: *** [../scripts/Makefile.modpost:150: modules-only.symvers]
> > Error 1
> >> make[1]: *** [/next-queue/Makefile:1754: modules] Error 2
> >> make: *** [Makefile:215: __sub-make] Error 2
> >
> 
> I'm not certain which divisions are causing problems, but I suspect it
> is the roundup() macro and/or some of the % modulo operations.

This patch should fix that issue. It removes all of the built-in operations done on u64.
Let me know if it works.

Regards
Maciek
Intel Technology Poland sp. z o.o.
ul. Sowackiego 173 | 80-298 Gdask | Sd Rejonowy Gdask Pnoc | VII Wydzia Gospodarczy Krajowego Rejestru Sdowego - KRS 101882 | NIP 957-07-52-316 | Kapita zakadowy 200.000 PLN.
Ta wiadomo wraz z zacznikami jest przeznaczona dla okrelonego adresata i moe zawiera informacje poufne. W razie przypadkowego otrzymania tej wiadomoci, prosimy o powiadomienie nadawcy oraz trwae jej usunicie; jakiekolwiek przegldanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ice-Fix-phase-calculation-in-ice_ptp_cfg_clkout.patch
Type: application/octet-stream
Size: 2132 bytes
Desc: 0001-ice-Fix-phase-calculation-in-ice_ptp_cfg_clkout.patch
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210615/e9ebd089/attachment-0001.obj>
