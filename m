From: Joerg Albert <jal2@gmx.de>
Date: Mon, 27 Jun 2016 17:50:14 +0200
Subject: [Intel-wired-lan] e1000e driver failed with error -3 after
 power-on
In-Reply-To: <5754307E.5030000@gmx.de>
References: <5754307E.5030000@gmx.de>
Message-ID: <57714B36.2050104@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 05.06.2016 16:00, Joerg Albert wrote:

> I've added some more debugging printout and I see that the EECD > register contains 0x200 in the error case and 0x300 if everything is > working. So either the NVM cannot be accessed or reading the > signature failed. I've checked the GbE part of my SPI Flash and the > Shared Init Control Word (word offset 0x13) in the first part has > bits 15:14 set to 10, i.e. a valid signature. Are these two documents > valid for my hardware?

> [1] http://www.intel.com/content/dam/doc/manual/i-o-controller-hub-8-9-10-82566-82567-82562v-software-dev-manual.pdf > [2] http://www.intel.com/content/dam/doc/datasheet/82579-gbe-phy-datasheet-vol-2-1.pdf
As I'd like to use my T520 without the need to always reset it after a power cycle, I've bought a second mainboard.
Before swapping the systemboard of my I'll try to rewrite the GbE and, if this won't help, the Intel ME region of the SPI flash.
BTW, same error shows up with Windows 7 64Bit.


Regards,
Joerg
