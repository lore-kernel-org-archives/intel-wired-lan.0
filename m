From: Vasiliy Tolstov <v.tolstov@selfip.ru>
Date: Mon, 19 Dec 2016 14:06:25 +0300
Subject: [Intel-wired-lan] ixgbe 4.2.1-k initiating reset due to tx timeout
Message-ID: <CACaajQsSFcuMDNVrEbCAkJQABLCKO+LRPrZwb=T9ahqhRpVNrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi! I'm using 4.4.x stable kernel and have errors in SFP+ network card
on two servers.

filename:
/lib/modules/4.4.x/kernel/drivers/net/ethernet/intel/ixgbe/ixgbe.ko
version:        4.2.1-k
license:        GPL
description:    Intel(R) 10 Gigabit PCI Express Network Driver
author:         Intel Corporation, <linux.nics@intel.com>

Does Intel own driver already have fix for this issue? What i need to
do to fix this?

Full log:
[Sat Dec 17 05:41:33 2016] ixgbe 0000:05:00.0 eth0: tx hang 12
detected on queue 6, resetting adapter
[Sat Dec 17 05:41:33 2016] ixgbe 0000:05:00.0 eth0: initiating reset
due to tx timeout
[Sat Dec 17 05:41:33 2016] ixgbe 0000:05:00.0 eth0: Detected Tx Unit Hang
  Tx Queue             <8>
  TDH, TDT             <0>, <16c>
  next_to_use          <0>
  next_to_clean        <0>
tx_buffer_info[next_to_clean]
  time_stamp           <0>
  jiffies              <10f8de392>
[Sat Dec 17 05:41:33 2016] ixgbe 0000:05:00.0 eth0: tx hang 12
detected on queue 8, resetting adapter
[Sat Dec 17 05:41:33 2016] ixgbe 0000:05:00.0 eth0: initiating reset
due to tx timeout
[Sat Dec 17 05:41:33 2016] ixgbe 0000:05:00.0 eth0: Detected Tx Unit Hang
  Tx Queue             <9>
  TDH, TDT             <0>, <4>
  next_to_use          <4>
  next_to_clean        <0>
tx_buffer_info[next_to_clean]
  time_stamp           <10f8de364>
  jiffies              <10f8de392>
[Sat Dec 17 05:41:33 2016] ixgbe 0000:05:00.0 eth0: Detected Tx Unit Hang
  Tx Queue             <10>
  TDH, TDT             <0>, <82>
  next_to_use          <2>
  next_to_clean        <0>
tx_buffer_info[next_to_clean]
  time_stamp           <10f8de270>
  jiffies              <10f8de392>
[Sat Dec 17 05:41:33 2016] ixgbe 0000:05:00.0 eth0: tx hang 12
detected on queue 9, resetting adapter
[Sat Dec 17 05:41:33 2016] ixgbe 0000:05:00.0 eth0: initiating reset
due to tx timeout
[Sat Dec 17 05:41:33 2016] ixgbe 0000:05:00.0 eth0: tx hang 12
detected on queue 10, resetting adapter
[Sat Dec 17 05:41:33 2016] ixgbe 0000:05:00.0 eth0: initiating reset
due to tx timeout
[Sat Dec 17 05:41:33 2016] ixgbe 0000:05:00.0 eth0: Reset adapter
[Sat Dec 17 05:41:33 2016] ixgbe 0000:05:00.0 eth0: tx hang 13
detected on queue 4, resetting adapter
[Sat Dec 17 05:41:33 2016] ixgbe 0000:05:00.1 eth2: Detected Tx Unit Hang
  Tx Queue             <21>
  TDH, TDT             <21>, <1022>
  next_to_use          <c2>
  next_to_clean        <c2>
tx_buffer_info[next_to_clean]
  time_stamp           <1095cdc2f>
  jiffies              <10f8de3ad>
[Sat Dec 17 05:41:33 2016] ixgbe 0000:05:00.1 eth2: Detected Tx Unit Hang
  Tx Queue             <22>
  TDH, TDT             <8f>, <90>
  next_to_use          <db>
  next_to_clean        <db>
tx_buffer_info[next_to_clean]
  time_stamp           <10b77e84c>
  jiffies              <10f8de3ad>
[Sat Dec 17 05:41:33 2016] ixgbe 0000:05:00.1 eth2: tx hang 1 detected
on queue 22, resetting adapter
[Sat Dec 17 05:41:33 2016] ixgbe 0000:05:00.1 eth2: initiating reset
due to tx timeout
[Sat Dec 17 05:41:33 2016] ixgbe 0000:05:00.1 eth2: Reset adapter
[Sat Dec 17 05:41:33 2016] ixgbe 0000:05:00.1 eth2: tx hang 2 detected
on queue 21, resetting adapter
[Sat Dec 17 05:41:33 2016] ixgbe 0000:05:00.1 eth2: initiating reset
due to tx timeout
[Sat Dec 17 05:41:34 2016] ixgbe 0000:05:00.0 eth0: detected SFP+: 5
[Sat Dec 17 05:41:34 2016] ixgbe 0000:05:00.1 eth2: detected SFP+: 6
[Sat Dec 17 05:41:34 2016] ixgbe 0000:05:00.0 eth0: NIC Link is Up 10
Gbps, Flow Control: RX/TX
[Sat Dec 17 05:41:34 2016] ixgbe 0000:05:00.1 eth2: NIC Link is Up 10
Gbps, Flow Control: RX/TX



-- 
Vasiliy Tolstov,
e-mail: v.tolstov at selfip.ru
