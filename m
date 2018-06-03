From: Andre Tomt <andre@tomt.net>
Date: Sun, 3 Jun 2018 09:55:38 +0200
Subject: [Intel-wired-lan] (bisected) ixgbe tx hang since 4.16-rc1
Message-ID: <24be0439-1b01-f577-1bab-eb166c8864ab@tomt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello

Since kernel 4.16-rc1 and including linus mainline git tree as of 
earlier today this Atom Denverton system with a X553 embedded network 
controllers has been unable to send packets until I kick the interface 
with a ethtool -r or leave it alone until it trips the TX Unit Hang 
watchdog.

The watchdog gets it going eventually, but this can take a while, as 
seen here:

> [   14.132485] ixgbe 0000:05:00.0 eno1: NIC Link is Up 1 Gbps, Flow Control: None
> [   14.133006] IPv6: ADDRCONF(NETDEV_CHANGE): eno1: link becomes ready
> [ 1085.067049] ixgbe 0000:05:00.0 eno1: Detected Tx Unit Hang 
>                  Tx Queue             <4>
>                  TDH, TDT             <1ab>, <1af>
>                  next_to_use          <1af>
>                  next_to_clean        <1ab>
>                tx_buffer_info[next_to_clean]
>                  time_stamp           <1000393d8>
>                  jiffies              <100039800>
> [ 1085.081184] ixgbe 0000:05:00.0 eno1: tx hang 1 detected on queue 4, resetting adapter
> [ 1085.081189] ixgbe 0000:05:00.0 eno1: initiating reset due to tx timeout
> [ 1085.082480] ixgbe 0000:05:00.0 eno1: Reset adapter
> [ 1085.083135] ixgbe 0000:05:00.0 eno1: NIC Link is Down
> [ 1088.729499] ixgbe 0000:05:00.0 eno1: NIC Link is Up 1 Gbps, Flow Control: None

A bisection turned up this commit:
49a94d74d9489647dfc3449ee135af4bf8fab2c1 is the first bad commit
commit 49a94d74d9489647dfc3449ee135af4bf8fab2c1
Author: Shannon Nelson <shannon.nelson@oracle.com>
Date:   Tue Dec 19 15:59:55 2017 -0800

     ixgbe: add ipsec engine start and stop routines

     Add in the code for running and stopping the hardware ipsec
     encryption/decryption engine.  It is good to keep the engine
     off when not in use in order to save on the power draw.

     Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
     Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
     Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

:040000 040000 417954917c2d03feaa973e4cce5ca8f53b099c94 
66091763e776ef25a33417a375d8ce149f01b61f M	drivers

Just reverting that commit on 4.17 is a no go, so I verified it by 
commenting out the call to ixgbe_ipsec_stop_engine(adapter) in 
ixgbe_init_ipsec_offload(), and lo and behold, packets started moving 
without intervention again.

This is a Supermicro A2SDi-8C-HLN4F, Atom C3758 (Denverton) system with 
"Intel Corporation Ethernet Connection X553 1GbE (rev 11)" according to 
pci-id db.

I'm not using ipsec on this system. The modules are built but not loaded.
