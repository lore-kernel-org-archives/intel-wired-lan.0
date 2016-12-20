From: Martin Kraus <lists_mk@wujiman.net>
Date: Tue, 20 Dec 2016 14:56:11 +0100
Subject: [Intel-wired-lan] i40e, macvlan interface,
	interface blocks incoming vrrp multicasts
Message-ID: <20161220135611.clpmpq2y6jja4bfg@finrod>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi.
We got intel XL710 card using i40e driver running on debian with kernel 4.9.0-rc8-amd64
(from experimental repo) and we are trying to get vrrp version 3 working using uvrrpd. 

The problem we are having is that after a macvlan interface is created to
simulate the virtual mac address the interface stops accepting incoming frames
with this source mac address which stops vrrp from finding out that a higher
priority router came online and thus has a potential to create two vrrp masters in
the network. 

We are using this setup on gigabit ethernets (both intel and broadcom) and on
X520 Intel chipsets and it has been working ok so far so this must be some new
feature of the X710 chipset/drivers.

This is the normal input without macvlan:

root at gw-b-01:/home/mkraus#> tcpdump -i eth5 -ne proto 112 and ip6 -Q in
tcpdump: verbose output suppressed, use -v or -vv for full protocol decode 
listening on eth5, link-type EN10MB (Ethernet), capture size 262144 bytes
13:42:12.536913 00:00:5e:00:02:67 > 33:33:00:00:00:12, ethertype IPv6 (0x86dd), length 94: fe80::6e9c:edff:fe1d:164b > ff02::12: ip-proto-112 40
13:42:13.496924 00:00:5e:00:02:67 > 33:33:00:00:00:12, ethertype IPv6 (0x86dd), length 94: fe80::6e9c:edff:fe1d:164b > ff02::12: ip-proto-112 40
13:42:14.356490 00:00:5e:00:02:67 > 33:33:00:00:00:12, ethertype IPv6 (0x86dd), length 94: fe80::6e9c:edff:fe1d:164b > ff02::12: ip-proto-112 40

where 00:00:5e:00:02:67 is the vrrp virtual mac address and 33:33:00:00:00:12
the multicast to which ipv6 vrrp multicasts.

Adding macvlan still ok

ip link add link eth5 name vip address 00:00:5e:00:02:67 type macvlan

Bringing macvlan vip up will start filtering the incoming vrrp multicasts for
the particular vrid which has a unique source mac address 00:00:5e:00:02:67
(other vrrp instances with different vrids still work ok).

The only way we found that works around this problem is using bridge interfaces
which I assume the driver detects and doesn't set hardware filters on the
interface.

However we'll be using X710 a lot in the coming years and would like to
resolve this issue without being forced to run bridge interfaces everywhere we
need vrrp.

Am I right in assuming that the current behaviour is incorrect? 
Thanks for your help
regards
Martin
