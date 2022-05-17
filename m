From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 17 May 2022 13:45:50 -0700
Subject: [Intel-wired-lan] Bonding problem on Intel X710 hardware
In-Reply-To: <ad3e244d-2f87-c74b-1d40-c21e286a721c@anduras.de>
References: <700118d5-2007-3c13-af2d-3a2a6c7775bd@anduras.de>
 <ad3e244d-2f87-c74b-1d40-c21e286a721c@anduras.de>
Message-ID: <20220517134550.7c451a83@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

CC: intel

On Tue, 17 May 2022 16:23:16 +0200 Sven Anders wrote:
> Hello!
> 
> This is a follow up to my question. I did not hear anything so far, but I tried
> to find some some information meanwhile.
> 
> I've got a guess from somebody, that the error message "Error I40E_AQ_RC_EINVAL
> adding RX filters on PF, promiscuous mode forced on" maybe triggered, because
> I'm hitting a limit here.
> 
> Somebody other said, that this seems to be an error in the "bonding driver", but
> I do not think so. Aside from that, there seem to be no special "bonding" mailing
> list anymore. So I will have to ask this questions here anyway...
> 
> I want to understand the problem to classify it.
> 
> 1) Why is this "error" issued? Do I really hit a limit and what is this current limit?
> 2) Is it really an error or is it more "a warning"?
> 3) Why is this error triggered only when changing the "ntuples filter" and not during
>     the normal adding of VLANs?
>     Remark: I can trigger the "ntuples fiilter" later on again and it still works.
> 
> I also tried the latest 5.18-rc kernel with the same problem.
> 
> Maybe somebody will find time and try to reproduce this?
> I will answer any questions...
> 
> Regards
>   Sven
> 
> Am 12.05.22 um 16:05 schrieb Sven Anders:
> > Hello!
> > 
> > I'm having problems setting up a bond in adaptive load balancing
> > mode (balance-alb, mode 6) on an intel X710 network adapter using
> > the i40e driver connected to an Aruba 2530-48G switch.
> > The network card has 4 on board ports.
> > I'm using 2 ports for the bond with 36 VLANs on it.
> > 
> > The setup is correct, because it works without problems, if
> > I use the same setup with 1GBit Intel hardware (using the
> > e1000e driver, version 3.2.6-k, firmware 5.10-2).
> > 
> > Data packets are only received sporadically. If I run the same test
> > with only one slave port, it works without problems.
> > 
> > I debugged it down to the reception of the packets by the
> > network hardware.
> > 
> > If I remove the number of VLANs under 8, almost all packets are
> > received. The fewer VLANs the better the receive rate.
> > 
> > I suspected the hardware offloading operations to be the cause, so I
> > tried to disable them. It resulted in the following:
> > 
> >  ?If I turn of the "ntuple-filters" with
> >  ?? ethtool -K eth3 ntuple off
> >  ?? ethtool -K eth3 ntuple off
> >  ?it will work.
> > 
> >  ?But if I do this I see the following errors in "dmesg":
> >  ? i40e 0000:65:00.1: Error I40E_AQ_RC_EINVAL adding RX filters on PF, promiscuous mode forced on
> >  ? i40e 0000:65:00.2: Error I40E_AQ_RC_EINVAL adding RX filters on PF, promiscuous mode forced on
> > 
> > Disabling any any other offloading operations made no change.
> > 
> > For me it seems, that the hardware filter is dropping packets because they
> > have the wrong values (mac-address ?).
> > Turning the "ntuple-filters" off, forces the network adapter to accept
> > all packets.
> > 
> > 
> > My questions:
> > 
> > 1. Can anybody explain or confirm this?
> > 
> > 2. Is the a correct method to force the adapter in promiscous mode?
> > 
> > 3. Are the any special settings needed, if I use ALB bonding, which I missed?
> > 
> > 
> > Some details:
> > -------------
> > 
> > Linux kernel 5.15.35-core2 on x86_64.
> > 
> > 
> > This is the hardware:
> > ---------------------
> > 4 port Ethernet controller:
> >  ?Intel Corporation Ethernet Controller X710 for 10GBASE-T (rev 02)
> >  ?8086:15ff (rev 02)
> > 
> > with
> > 
> >  ?driver: i40e
> >  ?version: 5.15.35-core2
> >  ?firmware-version: 8.60 0x8000bd80 1.3140.0
> >  ?bus-info: 0000:65:00.2
> >  ?supports-statistics: yes
> >  ?supports-test: yes
> >  ?supports-eeprom-access: yes
> >  ?supports-register-dump: yes
> >  ?supports-priv-flags: yes
> > 
> > 
> > This is current bonding configuration:
> > --------------------------------------
> > Ethernet Channel Bonding Driver: v5.15.35-core2
> > 
> > Bonding Mode: adaptive load balancing
> > Primary Slave: None
> > Currently Active Slave: eth3
> > MII Status: up
> > MII Polling Interval (ms): 100
> > Up Delay (ms): 200
> > Down Delay (ms): 200
> > Peer Notification Delay (ms): 0
> > 
> > Slave Interface: eth3
> > MII Status: up
> > Speed: 1000 Mbps
> > Duplex: full
> > Link Failure Count: 0
> > Permanent HW addr: 68:05:ca:f8:9c:42
> > Slave queue ID: 0
> > 
> > Slave Interface: eth4
> > MII Status: up
> > Speed: 1000 Mbps
> > Duplex: full
> > Link Failure Count: 0
> > Permanent HW addr: 68:05:ca:f8:9c:41
> > Slave queue ID: 0
> > 
> > 
> > Regards
> >  ?Sven Anders
> >   
> 
> 
> Mit freundlichen Gr??en
>   Sven Anders
> 

