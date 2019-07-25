From: Michal Purzynski <michal@mozilla.com>
Date: Thu, 25 Jul 2019 14:06:06 -0700
Subject: [Intel-wired-lan] (no subject)
Message-ID: <CADL_+2hTEZ5pyQ4LeiiMY-5BAH=-2Fay_-X8oAy=W4YrN040Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hey, I found some behavior of the flow-director that looks like a bug and
wanted to share.

When trying to drop some GRE traffic with a rule like this (where
10.251.0.194 is the source of the traffic)

ethtool -N enp17s0f0 flow-type ip4 src-ip 10.251.0.194 action -1

The following rule has been created

root at nsm1~ # ethtool -u enp17s0f0
4 RX rings available
Total 1 rules

Filter: 7679
Rule Type: Raw IPv4
Src IP addr: 10.251.0.194 mask: 0.0.0.0
Dest IP addr: 0.0.0.0 mask: 255.255.255.255
TOS: 0x0 mask: 0xff
Protocol: 0 mask: 0xff
L4 bytes: 0x0 mask: 0xffffffff
Action: Drop

Traffic from 10.251.0.194 is not being dropped at all - I can see it with
tcpdump.

20:27:46.579094 00:0b:86:b5:69:17 > 70:3a:0e:c9:f2:ea, ethertype 802.1Q
(0x8100), length 106: vlan 206, p 0, ethertype IPv4, (tos 0x0, ttl 63, id
51921, offset 0, flags [DF], proto GRE (47), length 88)
    10.251.0.194 > 10.251.1.136: GREv0, Flags [none], proto Loopback
(0x9000), length 68
gre-proto-0x9000

ntuple filters are enabled (and so is RSS with a low-entropy hash key)

ntuple-filters: on
receive-hashing: on

The fdir_sb_match counter keeps increasing, but at a much slower rate than
expected. It goes up by like 1 packets every N seconds - and I have a
steady flow of those GRE packets (over 100/sec).

port.fdir_sb_match: 295983
port.fdir_sb_status: 1

I also tried including the Vlan ID, but the documentation says it's ignored
- and indeed, trying to insert it when a non-vlan rule exists already,
results in a message

root at nsm1~ # ethtool -N enp17s0f0 flow-type ip4 src-ip 10.251.0.194 vlan
206 action -1
rmgr: Cannot insert RX class rule: Invalid argument

The exact same filter works on cards from different vendors, like Mellanox.
Could it be that I'm running into some FD limits here? If you need a pcap,
let me know and I'll share - off the list.

--
Michal Purzynski
Threat Management
Mozilla Corporation
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190725/78841b4c/attachment-0001.html>
