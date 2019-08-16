From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Fri, 16 Aug 2019 01:46:04 +0000
Subject: [Intel-wired-lan] x
In-Reply-To: <CAP-MU4MAwQd5bOGpJ=tu4iVB4j4FO6UWbkXg6ox34i7pb5DjQA@mail.gmail.com>
References: <CAP-MU4MAwQd5bOGpJ=tu4iVB4j4FO6UWbkXg6ox34i7pb5DjQA@mail.gmail.com>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD69AFFB063@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

x722? x550? Or is it a different part?

I've seen something like this lately, but I'll need to know which Ethernet controller it is before I can narrow it down.

Todd Fujinaka
Software Application Engineer
Datacenter Engineering Group
Intel Corporation
todd.fujinaka at intel.com

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of Shannon Nelson
Sent: Thursday, August 15, 2019 2:35 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] x

We've been occasionally seeing some of these messages recently on some of our machines after reboots.  Usually a powercycle clears it up.
Any hints as to what might be going on?

[    2.570012] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver -
version 5.1.0-k-rh7.5
[    2.570016] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[    4.883541] ixgbe 0000:65:00.0 (unregistered net_device): eeprom
read at offset 40 failed
[    7.112885] ixgbe 0000:65:00.0 (unregistered net_device): eeprom
read at offset 39 failed
[   11.571710] ixgbe 0000:65:00.0: The EEPROM Checksum Is Not Valid
[   11.571916] ixgbe: probe of 0000:65:00.0 failed with error -5
[   13.922688] ixgbe 0000:65:00.1 (unregistered net_device): eeprom
read at offset 40 failed
[   16.152080] ixgbe 0000:65:00.1 (unregistered net_device): eeprom
read at offset 39 failed
[   20.617460] ixgbe 0000:65:00.1: The EEPROM Checksum Is Not Valid
[   20.617639] ixgbe: probe of 0000:65:00.1 failed with error -5


Thanks,
sln


--
==============================================
Mr. Shannon Nelson         Parents can't afford to be squeamish.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
