From: Joerg Albert <jal2@gmx.de>
Date: Mon, 16 May 2016 13:52:56 +0200
Subject: [Intel-wired-lan] e1000e driver failed with error -3 after power-on
 and works after reboot
Message-ID: <5739B498.6050807@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,


when I power on my Thinkpad T520 (running Ubuntu 16.04) I see that the driver e1000e is loaded
but the interface is missing. After a reboot (without a power-cycle) the
interface appears and works fine.

dmesg  | grep e1000e
[    1.081798] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    1.081800] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.082068] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    2.106194] e1000e: probe of 0000:00:19.0 failed with error -3

Afterwards I've added some error output and changed some debugs into error prints in the e1000e and compiled my own kernel based on the latest vanilla version
(on a 14.04 Ubuntu SSD for speed reasons):

[ 7900.183212] e1000e 0000:00:19.0 0000:00:19.0 (uninitialized): Failed to acquire the semaphore, FW or HW has it: FWSM=0x60000040 EXTCNF_CTRL=0x002800c9)

How can the hardware hold the semaphore after power-up, but not after reset? Is there something wrong with the GbE region of my SPI flash?
The checksum of the first region is valid.

cat /proc/version
Linux version 4.6.0-jal2+ (root at x61) (gcc version 4.8.4 (Ubuntu 4.8.4-2ubuntu1~14.04.1) ) #4 SMP Mon May 16 01:06:19 CEST 2016


lspci -s 00:19 -vvv
00:19.0 Ethernet controller: Intel Corporation 82579LM Gigabit Network Connection (rev 04)
        Subsystem: Lenovo Device 21ce
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at f3900000 (32-bit, non-prefetchable) [size=128K]
        Region 1: Memory at f3929000 (32-bit, non-prefetchable) [size=4K]
        Region 2: I/O ports@6080 [size=32]
        Capabilities: [c8] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [e0] PCI Advanced Features
                AFCap: TP+ FLR+
                AFCtrl: FLR-
                AFStatus: TP-


You find a report for a similar bug on Ubuntu's Launchpad for a Clevo W130SV with a Intel I217-LM (rev 05), 8086:153a
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1576953

Regards,
Joerg
