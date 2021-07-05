From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Mon, 5 Jul 2021 09:47:22 +0200
Subject: [Intel-wired-lan] [net-next 00/13] ice: implement support for
 PTP on E822 hardware
In-Reply-To: <20210701002713.3486336-1-jacob.e.keller@intel.com>
References: <20210701002713.3486336-1-jacob.e.keller@intel.com>
Message-ID: <2226449e-2c2c-d72b-1bd2-1a44882251fe@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Jacob,


Thank you for sending the patches.


Am 01.07.21 um 02:27 schrieb Jacob Keller:
> Extend the ice driver implementation to support PTP for the E822 based
> devices.
> 
> This includes a few cleanup patches, that fix some minor issues spotted
> while preparing them. In addition, there are some slight refactors to ease
> the addition of E822 support, followed by adding the new hardware
> implementation ice_ptp_hw.c.
> 
> There are a few major differences with E822 support compared to E810
> support:
> 
> *) The E822 PHY is a bit different and requires a more complex
> initialization procedure that requires delaying the PHY start until link is
> up

It?d be great, if you gave concrete numbers.

[?]


Kind regards,

Paul
