From: Marco Berizzi <pupilla@libero.it>
Date: Tue, 28 Aug 2018 17:20:14 +0200 (CEST)
Subject: [Intel-wired-lan] igb Detected Tx Unit Hang after upgrade to
 4.18-rc6 [was Re: igb Detected Tx Unit Hang after upgrade to 4.17]
In-Reply-To: <403709248.209641.1533555587417@mail.libero.it>
References: <528200032.321946.1528186357567@mail.libero.it>
 <963322856.1365958.1530796944033@mail.libero.it>
 <931347915.758706.1532606173777@mail.libero.it>
 <CAKgT0UdmzKG6usaHqFt2N4q1FVX-8r58hbhWb9dc8ygS2UmKWQ@mail.gmail.com>
 <1265852288.743881.1532617415845@mail.libero.it>
 <CAKgT0Ud3CMQBKabty07ordkeDPoaaWK3_q3rMoAh7XMSJMSE9g@mail.gmail.com>
 <1312873949.790150.1532681266921@mail.libero.it>
 <117857591.886490.1532956286262@mail.libero.it>
 <403709248.209641.1533555587417@mail.libero.it>
Message-ID: <978998680.826474.1535469615050@mail.libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> Il 6 agosto 2018 alle 13.39 Marco Berizzi <pupilla@libero.it> ha scritto:
> 
> > Il 30 luglio 2018 alle 15.11 Marco Berizzi <pupilla@libero.it> ha scritto:
> > 
> > > Il 27 luglio 2018 alle 10.47 Marco Berizzi <pupilla@libero.it> ha scritto:
> > > 
> > > Should I disable the TSO? Or should I set all my linux boxes MTU to 1500?
> > 
> > Hello everyone,
> > 
> > One hour ago I upgraded to linux 4.18-rc7 and I set the MTU=1500
> > 
> > I will keep you updated.
> 
> After 6 days uptime I got the same error message with MTU=1500.
> Now I will upgrade to 4.18-rc8 with MTU=1500 and I will disable
> the tso with the following command: ethtool -K eth0 tso off

Hello everyone,
same error also with tso disabled:

[2226325.797978] igb 0000:08:00.0: Detected Tx Unit Hang
                   Tx Queue             <1>
                   TDH                  <cf>
                   TDT                  <cf>
                   next_to_use          <d0>
                   next_to_clean        <cf>
                 buffer_info[next_to_clean]
                   time_stamp           <184aee600>
                   next_to_watch        <000000003e213f5a>
                   jiffies              <184aeea00>
                   desc.status          <a8010>
[2226327.782078] igb 0000:08:00.0: Detected Tx Unit Hang
                   Tx Queue             <1>
                   TDH                  <cf>
                   TDT                  <cf>
                   next_to_use          <d0>
                   next_to_clean        <cf>
                 buffer_info[next_to_clean]
                   time_stamp           <184aee600>
                   next_to_watch        <000000003e213f5a>
                   jiffies              <184aef1c0>
                   desc.status          <a8010>
[2226329.765929] igb 0000:08:00.0: Detected Tx Unit Hang
                   Tx Queue             <1>
                   TDH                  <cf>
                   TDT                  <cf>
                   next_to_use          <d0>
                   next_to_clean        <cf>
                 buffer_info[next_to_clean]
                   time_stamp           <184aee600>
                   next_to_watch        <000000003e213f5a>
                   jiffies              <184aef980>
                   desc.status          <a8010>
[2226331.813901] igb 0000:08:00.0: Detected Tx Unit Hang
                   Tx Queue             <1>
                   TDH                  <cf>
                   TDT                  <cf>
                   next_to_use          <d0>
                   next_to_clean        <cf>
                 buffer_info[next_to_clean]
                   time_stamp           <184aee600>
                   next_to_watch        <000000003e213f5a>
                   jiffies              <184af0180>
                   desc.status          <a8010>
[2226333.797875] igb 0000:08:00.0: Detected Tx Unit Hang
                   Tx Queue             <1>
                   TDH                  <cf>
                   TDT                  <cf>
                   next_to_use          <d0>
                   next_to_clean        <cf>
                 buffer_info[next_to_clean]
                   time_stamp           <184aee600>
                   next_to_watch        <000000003e213f5a>
                   jiffies              <184af0940>
                   desc.status          <a8010>
[2226333.989876] igb 0000:08:00.0 eth0: Reset adapter
[2226337.054234] igb 0000:08:00.0 eth0: igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
root at Kaa:~# ethtool -k eth0
Features for eth0:
Cannot get device udp-fragmentation-offload settings: Operation not supported
rx-checksumming: on
tx-checksumming: on
        tx-checksum-ipv4: off [fixed]
        tx-checksum-ip-generic: on
        tx-checksum-ipv6: off [fixed]
        tx-checksum-fcoe-crc: off [fixed]
        tx-checksum-sctp: off [fixed]
scatter-gather: on
        tx-scatter-gather: on
        tx-scatter-gather-fraglist: off [fixed]
tcp-segmentation-offload: off
        tx-tcp-segmentation: off
        tx-tcp-ecn-segmentation: off [fixed]
        tx-tcp-mangleid-segmentation: off
        tx-tcp6-segmentation: off
udp-fragmentation-offload: off
generic-segmentation-offload: on
generic-receive-offload: on
large-receive-offload: off [fixed]
rx-vlan-offload: on
tx-vlan-offload: on
ntuple-filters: off [fixed]
receive-hashing: on
highdma: on [fixed]
rx-vlan-filter: on [fixed]
vlan-challenged: off [fixed]
tx-lockless: off [fixed]
netns-local: off [fixed]
tx-gso-robust: off [fixed]
tx-fcoe-segmentation: off [fixed]
tx-gre-segmentation: on
tx-gre-csum-segmentation: on
tx-ipxip4-segmentation: on
tx-ipxip6-segmentation: on
tx-udp_tnl-segmentation: on
tx-udp_tnl-csum-segmentation: on
tx-gso-partial: on
tx-sctp-segmentation: off [fixed]
tx-esp-segmentation: off [fixed]
tx-udp-segmentation: off [fixed]
fcoe-mtu: off [fixed]
tx-nocache-copy: off
loopback: off [fixed]
rx-fcs: off [fixed]
rx-all: off
tx-vlan-stag-hw-insert: off [fixed]
rx-vlan-stag-hw-parse: off [fixed]
rx-vlan-stag-filter: off [fixed]
l2-fwd-offload: off [fixed]
hw-tc-offload: off [fixed]
esp-hw-offload: off [fixed]
esp-tx-csum-hw-offload: off [fixed]
rx-udp_tunnel-port-offload: off [fixed]
tls-hw-tx-offload: off [fixed]
rx-gro-hw: off [fixed]
tls-hw-record: off [fixed]
