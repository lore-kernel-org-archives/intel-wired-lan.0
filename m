From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 6 Jul 2021 19:53:51 +0000
Subject: [Intel-wired-lan] [net-next 00/13] ice: implement support for
 PTP on E822 hardware
In-Reply-To: <2226449e-2c2c-d72b-1bd2-1a44882251fe@molgen.mpg.de>
References: <20210701002713.3486336-1-jacob.e.keller@intel.com>
 <2226449e-2c2c-d72b-1bd2-1a44882251fe@molgen.mpg.de>
Message-ID: <e1a3cb86cb7e43d29b6b5e4663029bfe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Paul Menzel <pmenzel@molgen.mpg.de>
> Sent: Monday, July 05, 2021 12:47 AM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [net-next 00/13] ice: implement support for PTP on
> E822 hardware
> 
> Dear Jacob,
> 
> 
> Thank you for sending the patches.
> 
> 
> Am 01.07.21 um 02:27 schrieb Jacob Keller:
> > Extend the ice driver implementation to support PTP for the E822 based
> > devices.
> >
> > This includes a few cleanup patches, that fix some minor issues spotted
> > while preparing them. In addition, there are some slight refactors to ease
> > the addition of E822 support, followed by adding the new hardware
> > implementation ice_ptp_hw.c.
> >
> > There are a few major differences with E822 support compared to E810
> > support:
> >
> > *) The E822 PHY is a bit different and requires a more complex
> > initialization procedure that requires delaying the PHY start until link is
> > up
> 
> It?d be great, if you gave concrete numbers.
> 

Concrete numbers on which part? I'm not sure if we have concrete numbers on everything here. For the calibration process, according to the data sheet I have, it indicates that uncalibrated timestamps (i.e. in bypass mode) have an error of up to 1 clock cycle and calibrated timestamps should have an error of less than 1/8th of a clock cycle. Here clock cycle refers to the length of one tick on the clock source, and error refers to difference between actual start of reception or transmission vs time of when the timstamp is captured. I unfortunately am not at all sure how this was measured by the hardware folks...

> [?]
> 
> 
> Kind regards,
> 
> Paul
