From: Vasiliy Tolstov <v.tolstov@selfip.ru>
Date: Wed, 29 Mar 2017 10:50:21 +0300
Subject: [Intel-wired-lan] reset 10Gb SPF port on linux 4.4.x LTS
Message-ID: <CACaajQvMvfvYc7=DAr_C2JW4HeHz9E7SOmD-kimZ3AA13wSLPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I have two port Intel Corporation 82599ES 10-Gigabit SFI/SFP+ Network
Connection adapter

Sometimes when pps goes to 200000 i have errors like below. Also note
that when i manually generate traffic via hping3 i don't see any
errors with packet rate is about 600000. How can i fix this issue and
why it happening?
Also note that from switch side i don't see any errors, but from
server side i see packet drops.

ixgbe 0000:05:00.0 eth0: tx hang 12 detected on queue 6, resetting adapter
ixgbe 0000:05:00.0 eth0: initiating reset due to tx timeout
ixgbe 0000:05:00.0 eth0: Detected Tx Unit Hang
  Tx Queue             <8>
  TDH, TDT             <0>, <16c>
  next_to_use          <0>
  next_to_clean        <0>
tx_buffer_info[next_to_clean]
  time_stamp           <0>
  jiffies              <10f8de392>
ixgbe 0000:05:00.0 eth0: tx hang 12 detected on queue 8, resetting adapter
ixgbe 0000:05:00.0 eth0: initiating reset due to tx timeout
ixgbe 0000:05:00.0 eth0: Detected Tx Unit Hang
  Tx Queue             <9>
  TDH, TDT             <0>, <4>
  next_to_use          <4>
  next_to_clean        <0>
tx_buffer_info[next_to_clean]
  time_stamp           <10f8de364>
  jiffies              <10f8de392>
ixgbe 0000:05:00.0 eth0: Detected Tx Unit Hang
  Tx Queue             <10>
  TDH, TDT             <0>, <82>
  next_to_use          <2>
  next_to_clean        <0>
tx_buffer_info[next_to_clean]
  time_stamp           <10f8de270>
  jiffies              <10f8de392>
ixgbe 0000:05:00.0 eth0: tx hang 12 detected on queue 9, resetting adapter
ixgbe 0000:05:00.0 eth0: initiating reset due to tx timeout
xgbe 0000:05:00.0 eth0: tx hang 12 detected on queue 10, resetting adapter
ixgbe 0000:05:00.0 eth0: initiating reset due to tx timeout
ixgbe 0000:05:00.0 eth0: Reset adapter
ixgbe 0000:05:00.0 eth0: tx hang 13 detected on queue 4, resetting adapter
ixgbe 0000:05:00.1 eth2: Detected Tx Unit Hang
  Tx Queue             <21>
  TDH, TDT             <21>, <1022>
  next_to_use          <c2>
  next_to_clean        <c2>
tx_buffer_info[next_to_clean]
  time_stamp           <1095cdc2f>
  jiffies              <10f8de3ad>
ixgbe 0000:05:00.1 eth2: Detected Tx Unit Hang
  Tx Queue             <22>
  TDH, TDT             <8f>, <90>
  next_to_use          <db>
  next_to_clean        <db>
tx_buffer_info[next_to_clean]
  time_stamp           <10b77e84c>
  jiffies              <10f8de3ad>
ixgbe 0000:05:00.1 eth2: tx hang 1 detected on queue 22, resetting adapter
ixgbe 0000:05:00.1 eth2: initiating reset due to tx timeout
ixgbe 0000:05:00.1 eth2: Reset adapter
ixgbe 0000:05:00.1 eth2: tx hang 2 detected on queue 21, resetting adapter
ixgbe 0000:05:00.1 eth2: initiating reset due to tx timeout
ixgbe 0000:05:00.0 eth0: detected SFP+: 5
ixgbe 0000:05:00.1 eth2: detected SFP+: 6
ixgbe 0000:05:00.0 eth0: NIC Link is Up 10 Gbps, Flow Control: RX/TX
ixgbe 0000:05:00.1 eth2: NIC Link is Up 10 Gbps, Flow Control: RX/TX

-- 
Vasiliy Tolstov,
e-mail: v.tolstov at selfip.ru
