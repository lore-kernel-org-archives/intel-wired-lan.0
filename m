From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Sun, 3 Jun 2018 17:15:43 -0700
Subject: [Intel-wired-lan] (bisected) ixgbe tx hang since 4.16-rc1
In-Reply-To: <24be0439-1b01-f577-1bab-eb166c8864ab@tomt.net>
References: <24be0439-1b01-f577-1bab-eb166c8864ab@tomt.net>
Message-ID: <f175e7ca-79fe-c6c2-98bc-8ced5ae88cc7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/3/2018 12:55 AM, Andre Tomt wrote:
> Hello
> 
> Since kernel 4.16-rc1 and including linus mainline git tree as of 
> earlier today this Atom Denverton system with a X553 embedded network 
> controllers has been unable to send packets until I kick the interface 
> with a ethtool -r or leave it alone until it trips the TX Unit Hang 
> watchdog.

Hi Andre,

Thanks for your bug report and the bisection.  I'm not aware of any 
differences in the x553 from the rest of the x5xx family, and I don't 
have access to one, so I can't do any testing of my own.

I can imagine how removing the call to ixgbe_ipsec_stop_engine() might 
help, but since the driver is still advertising support for the IPsec 
offload, I'm afraid there would still be other problems popping up if 
someone tried to use the offload.  If this particular device, or family 
of devices, is problematic, it might be better to simply filter them out 
at the top of ixgbe_init_ipsec_offload() like we do for the 82598.

In order to help our friends at Intel do some further investigation, 
would you please include the output from "lspci -s <pci-bdf> -nv" so we 
can know for sure which device this is?


Jeff, can you get someone in your test group to take look at this?  It 
would be good to know if IPsec offload on the embedded devices are going 
to cause us problems.

Thanks,
sln


> 
> The watchdog gets it going eventually, but this can take a while, as 
> seen here:
> 
>> [?? 14.132485] ixgbe 0000:05:00.0 eno1: NIC Link is Up 1 Gbps, Flow 
>> Control: None
>> [?? 14.133006] IPv6: ADDRCONF(NETDEV_CHANGE): eno1: link becomes ready
>> [ 1085.067049] ixgbe 0000:05:00.0 eno1: Detected Tx Unit Hang 
>> ???????????????? Tx Queue???????????? <4>
>> ???????????????? TDH, TDT???????????? <1ab>, <1af>
>> ???????????????? next_to_use????????? <1af>
>> ???????????????? next_to_clean??????? <1ab>
>> ?????????????? tx_buffer_info[next_to_clean]
>> ???????????????? time_stamp?????????? <1000393d8>
>> ???????????????? jiffies????????????? <100039800>
>> [ 1085.081184] ixgbe 0000:05:00.0 eno1: tx hang 1 detected on queue 4, 
>> resetting adapter
>> [ 1085.081189] ixgbe 0000:05:00.0 eno1: initiating reset due to tx 
>> timeout
>> [ 1085.082480] ixgbe 0000:05:00.0 eno1: Reset adapter
>> [ 1085.083135] ixgbe 0000:05:00.0 eno1: NIC Link is Down
>> [ 1088.729499] ixgbe 0000:05:00.0 eno1: NIC Link is Up 1 Gbps, Flow 
>> Control: None
> 
> A bisection turned up this commit:
> 49a94d74d9489647dfc3449ee135af4bf8fab2c1 is the first bad commit
> commit 49a94d74d9489647dfc3449ee135af4bf8fab2c1
> Author: Shannon Nelson <shannon.nelson@oracle.com>
> Date:?? Tue Dec 19 15:59:55 2017 -0800
> 
>  ??? ixgbe: add ipsec engine start and stop routines
> 
>  ??? Add in the code for running and stopping the hardware ipsec
>  ??? encryption/decryption engine.? It is good to keep the engine
>  ??? off when not in use in order to save on the power draw.
> 
>  ??? Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
>  ??? Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
>  ??? Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> 
> :040000 040000 417954917c2d03feaa973e4cce5ca8f53b099c94 
> 66091763e776ef25a33417a375d8ce149f01b61f M??? drivers
> 
> Just reverting that commit on 4.17 is a no go, so I verified it by 
> commenting out the call to ixgbe_ipsec_stop_engine(adapter) in 
> ixgbe_init_ipsec_offload(), and lo and behold, packets started moving 
> without intervention again.
> 
> This is a Supermicro A2SDi-8C-HLN4F, Atom C3758 (Denverton) system with 
> "Intel Corporation Ethernet Connection X553 1GbE (rev 11)" according to 
> pci-id db.
> 
> I'm not using ipsec on this system. The modules are built but not loaded.





