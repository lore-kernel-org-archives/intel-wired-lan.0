From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Thu, 3 Nov 2016 08:41:35 +0000
Subject: [Intel-wired-lan] Kernel regression introduced by "e1000e: Do
 not write lsc to ics in msi-x mode" and/or "e1000e: Do not read ICR in
 Other interrupt"
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B81FC067C@ORSMSX101.amr.corp.intel.com>
References: <1478044618.14119.774423193.0F79737A@webmail.messagingengine.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81FC067C@ORSMSX101.amr.corp.intel.com>
Message-ID: <630A6B92B7EDEB45A87E20D3D286660153E27B75@hasmsx109.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Brown, Aaron F
Sent: Wednesday, November 02, 2016 11:20 PM
To: Jack Suter <jack@suter.io>; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
Cc: bpoirier at suse.com; jhodzic at ucdavis.edu; intel-wired-lan at lists.osuosl.org; linux-kernel at vger.kernel.org
Subject: Re: [Intel-wired-lan] Kernel regression introduced by "e1000e: Do not write lsc to ics in msi-x mode" and/or "e1000e: Do not read ICR in Other interrupt"

> From: Jack Suter [mailto:jack at suter.io]
> Sent: Tuesday, November 1, 2016 4:57 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org; bpoirier at suse.com; Brown, Aaron 
> F <aaron.f.brown@intel.com>; jhodzic at ucdavis.edu; linux- 
> kernel at vger.kernel.org
> Subject: Kernel regression introduced by "e1000e: Do not write lsc to 
> ics in msi-x mode" and/or "e1000e: Do not read ICR in Other interrupt"
> 
> Hi there,
> 
> I have some servers with an 82574L based NIC and recently upgraded 
> from a 4.4 series kernel to 4.7. Upon doing so, servers with this 
> chipset have begun frequently reporting "Link is Down" and "Link is Up"
> messages. No other related network errors are reported by the kernel 
> or e1000e driver. I saw some reports about using "ethtool -s $iface 
> msglvl 6" to reveal more information, but nothing extra was reported.
> 
> Some testing showed that this was introduced between the 4.4 and 4.5 
> series. I was able to further narrow it down to two commits that look
> related:
> 
>  e1000e: Do not write lsc to ics in msi-x mode
>  (a61cfe4ffad7864a07e0c74969ca7ceb77ab2f1f)
>  e1000e: Do not read ICR in Other interrupt
>  (16ecba59bc333d6282ee057fb02339f77a880beb)

I did not notice any link flapping when I tested those patches, I would have rejected them if I had.  I have several systems with 82574L LOMs and as yet am not able to reproduce a link flap with recent upstream kernels/drivers (net-next 4.8.0 on one and 4.9.0-rc3 on another.) 

One of those systems is dedicated to a kernel regression setup, I checked the test logs from it and am not seeing any evidence of flaps in the 4.4, through 4.6 range either.

> 
> Reverting these two commits resolves the Link is Down/Link is Up 
> messages. This has been tested on about six servers so far and all 
> have stopped reporting these link flaps.

Are you able to revert either of the patches independently, I don't recall if they were stand alone or not.

> 
> In total I have about ten servers that are frequently seeing this 
> issue, and a couple dozen more triggering it sporadically.

Are they all 82574L or does it affect others?

> 
> This is about the extent of my troubleshooting knowledge so far. I am 
> happy to test code changes and provide any additional information as 
> necessary. While I do not understand what specifically causes the link 
> flaps, they reliably begin occurring on the affected servers within a 
> couple hours of boot.

Is there any particular traffic pattern involved?  Sitting idle, moderate use, heavy constant flow? 

> 
> A snip of one such instance is below.
> 
> Thank you for any assistance troubleshooting this.

Which kernel tree are you using?  Linus's upstream kernel from kernel.org, a distribution provided one or?  I'm generally working off of David Miller's net-next, but can try to repro the issue on my boxes if I know the exact kernel to work from.

Perhaps a power saving state trying to kick in?  Bad cables or speed/duplex mismatches are common causes of link flap, but they seem unlikely given reverting the patches resolves the issue.

Those patches are interrupt related, what kind of interrupts are in use?  What is interrupt moderation (coalescing set to)?  What is the link partner?  Same type switch for all problem machines or a mix?

cat /proc/interrupts
ethtool -c enp2s0

maybe an `lspci` dump could help shed some more light.

> 
> Kind regards,
> 
> Jack Suter
> 
> # ethtool -i enp2s0
> driver: e1000e
> version: 3.2.6-k
> firmware-version: 2.1-2
> bus-info: 0000:02:00.0
> supports-statistics: yes
> supports-test: yes
> supports-eeprom-access: yes
> supports-register-dump: yes
> supports-priv-flags: no
> 
> [ 3532.745587] e1000e: enp2s0 NIC Link is Down [ 3532.771461] e1000e: 
> enp2s0 NIC Link is Up 1000 Mbps Full Duplex, Flow
> Control: Rx/Tx
> [15463.117592] e1000e: enp2s0 NIC Link is Down [15463.119419] e1000e: 
> enp2s0 NIC Link is Up 1000 Mbps Full Duplex, Flow
> Control: Rx/Tx
> [15469.155922] e1000e: enp2s0 NIC Link is Up 1000 Mbps Full Duplex, 
> Flow
> Control: Rx/Tx
> [15648.196579] e1000e: enp2s0 NIC Link is Down [15651.405310] e1000e: 
> enp2s0 NIC Link is Up 1000 Mbps Full Duplex, Flow
> Control: Rx/Tx
> [15728.959981] e1000e: enp2s0 NIC Link is Down [15729.000625] e1000e: 
> enp2s0 NIC Link is Up 1000 Mbps Full Duplex, Flow
> Control: Rx/Tx
> [15835.132034] e1000e: enp2s0 NIC Link is Down [15835.185222] e1000e: 
> enp2s0 NIC Link is Up 1000 Mbps Full Duplex, Flow
> Control: Rx/Tx
> [15839.104020] e1000e: enp2s0 NIC Link is Down [15839.142346] e1000e: 
> enp2s0 NIC Link is Up 1000 Mbps Full Duplex, Flow
> Control: Rx/Tx
> [15845.142287] e1000e: enp2s0 NIC Link is Up 1000 Mbps Full Duplex, 
> Flow
> Control: Rx/Tx
> [16401.940127] e1000e: enp2s0 NIC Link is Down [16401.945106] e1000e: 
> enp2s0 NIC Link is Up 1000 Mbps Full Duplex, Flow
> Control: Rx/Tx
> [16408.121843] e1000e: enp2s0 NIC Link is Up 1000 Mbps Full Duplex, 
> Flow
> Control: Rx/Tx
> [17025.823220] e1000e: enp2s0 NIC Link is Down [17025.825473] e1000e: 
> enp2s0 NIC Link is Up 1000 Mbps Full Duplex, Flow
> Control: Rx/Tx
> [17032.100202] e1000e: enp2s0 NIC Link is Up 1000 Mbps Full Duplex, 
> Flow
> Control: Rx/Tx
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan

Hello,
We have no reproduced this problem in our labs too. We have tested x99 server platform with 82574L NIC and 4.8.0 kernel.
You wrote that you have several servers with this issue. What is platforms you use? Is there some specific platform's or link partner configuration? Interesting to know if you experienced such problem with stable 4.8.4 or mainline 4.9-rc3.
Sasha





