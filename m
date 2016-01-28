From: Skidmore, Donald C <donald.c.skidmore@intel.com>
Date: Thu, 28 Jan 2016 19:13:43 +0000
Subject: [Intel-wired-lan] anyone aware of problem with 82599ES
	stuck	sending TX pause frames?
In-Reply-To: <56AA60A1.7060408@windriver.com>
References: <56AA60A1.7060408@windriver.com>
Message-ID: <F6FB0E698C9B3143BDF729DF2228664691E709B9@ORSMSX116.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hey Chris,

I've seen issues that seemed similar to this caused by a switches not playing well with the NIC.  Are you going through a switch and if so could you see if you can recreate back to back with a different switch?

Likewise it might be interesting to try the OoT driver, just to see if a later fix addressed what you're seeing.  I can't think of anything off the top of my head, but trying the newer driver might help identify if we have.

Also are you seeing anything interesting on the system log?  

Thanks,
-Don

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Chris Friesen
> Sent: Thursday, January 28, 2016 10:41 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] anyone aware of problem with 82599ES stuck
> sending TX pause frames?
> 
> Hi,
> 
> We're running linux 3.10 with the 3.13.10-k ixgbe driver.  We're seeing an
> intermittent issue with our 82599ES devices where they seem to occasionally
> get stuck sending TX pause frames.
> 
> controller-1:~$ sudo ethtool -S eth26 | grep flow_control
>       tx_flow_control_xon: 0
>       rx_flow_control_xon: 0
>       tx_flow_control_xoff: 3446364
>       rx_flow_control_xoff: 0
> 
> [wrsroot at controller-1 ~(keystone_admin)]$ sudo ethtool -S eth6 | grep
> flow_control
>       tx_flow_control_xon: 103
>       rx_flow_control_xon: 0
>       tx_flow_control_xoff: 9174310
>       rx_flow_control_xoff: 0
> 
> 
> Generally it seems to happen after receiving a relatively small number of
> packets (though the data set is small so this may be chance):
> 
> 13: eth4.85 at eth4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9000
> qdisc htb state UP mode DEFAULT
>      link/ether 90:e2:ba:37:9b:ec brd ff:ff:ff:ff:ff:ff
>      RX: bytes  packets  errors  dropped overrun mcast
>      96681      212      0       0       0       192
>      TX: bytes  packets  errors  dropped carrier collsns
>      77054616   136387   0       0       0       0
> 
> 
> 29: eth26: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc htb
> state UP mode
> DEFAULT qlen 1000
>      link/ether 90:e2:ba:4f:9e:38 brd ff:ff:ff:ff:ff:ff
>      RX: bytes  packets  errors  dropped overrun mcast
>      105471     213      0       0       0       129291
>      TX: bytes  packets  errors  dropped carrier collsns
>      49801840   88058    0       0       0       0
> 
> ifdown/ifup seems to be sufficient to cause it to start behaving normally
> again.
> 
> Anyone seen anything like this?
> 
> Thanks,
> Chris
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
