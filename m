From: Joerg Albert <jal2@gmx.de>
Date: Sun, 5 Jun 2016 16:00:30 +0200
Subject: [Intel-wired-lan] e1000e driver failed with error -3 after
	power-on
Message-ID: <5754307E.5030000@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

jal2 at gmx.de wrote on May 16th:

> when I power on my Thinkpad T520 (running Ubuntu 16.04) I see that the driver e1000e is loaded
> but the interface is missing. After a reboot (without a power-cycle) the
> interface appears and works fine.

> dmesg  | grep e1000e
> [    1.081798] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> [    1.081800] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [    1.082068] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
> [    2.106194] e1000e: probe of 0000:00:19.0 failed with error -3

> Afterwards I've added some error output and changed some debugs into error prints in the e1000e and compiled my own kernel based on the latest vanilla version
> (on a 14.04 Ubuntu SSD for speed reasons):

> [ 7900.183212] e1000e 0000:00:19.0 0000:00:19.0 (uninitialized): Failed to acquire the semaphore, FW or HW has it: FWSM=0x60000040 EXTCNF_CTRL=0x002800c9)

I've added some more debugging printout and I see that the EECD register contains 0x200 in the error case and 0x300 if everything is working.
So either the NVM cannot be accessed or reading the signature failed.

I've checked the GbE part of my SPI Flash and the Shared Init Control Word (word offset 0x13) in the first part has bits 15:14 set to 10, i.e. a valid signature.

Are these two documents valid for my hardware?
[1] http://www.intel.com/content/dam/doc/manual/i-o-controller-hub-8-9-10-82566-82567-82562v-software-dev-manual.pdf
[2] http://www.intel.com/content/dam/doc/datasheet/82579-gbe-phy-datasheet-vol-2-1.pdf

Regards,
Joerg
