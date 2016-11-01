From: Jack Suter <jack@suter.io>
Date: Tue, 01 Nov 2016 19:56:58 -0400
Subject: [Intel-wired-lan] Kernel regression introduced by "e1000e: Do not
 write lsc to ics in msi-x mode" and/or "e1000e: Do not read ICR in Other
 interrupt"
Message-ID: <1478044618.14119.774423193.0F79737A@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi there,

I have some servers with an 82574L based NIC and recently upgraded from
a 4.4 series kernel to 4.7. Upon doing so, servers with this chipset
have begun frequently reporting "Link is Down" and "Link is Up"
messages. No other related network errors are reported by the kernel or
e1000e driver. I saw some reports about using "ethtool -s $iface msglvl
6" to reveal more information, but nothing extra was reported.

Some testing showed that this was introduced between the 4.4 and 4.5
series. I was able to further narrow it down to two commits that look
related:

 e1000e: Do not write lsc to ics in msi-x mode
 (a61cfe4ffad7864a07e0c74969ca7ceb77ab2f1f)
 e1000e: Do not read ICR in Other interrupt
 (16ecba59bc333d6282ee057fb02339f77a880beb)

Reverting these two commits resolves the Link is Down/Link is Up
messages. This has been tested on about six servers so far and all have
stopped reporting these link flaps.

In total I have about ten servers that are frequently seeing this issue,
and a couple dozen more triggering it sporadically.

This is about the extent of my troubleshooting knowledge so far. I am
happy to test code changes and provide any additional information as
necessary. While I do not understand what specifically causes the link
flaps, they reliably begin occurring on the affected servers within a
couple hours of boot.

A snip of one such instance is below.

Thank you for any assistance troubleshooting this.

Kind regards,

Jack Suter

# ethtool -i enp2s0
driver: e1000e
version: 3.2.6-k
firmware-version: 2.1-2
bus-info: 0000:02:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: no

[ 3532.745587] e1000e: enp2s0 NIC Link is Down
[ 3532.771461] e1000e: enp2s0 NIC Link is Up 1000 Mbps Full Duplex, Flow
Control: Rx/Tx
[15463.117592] e1000e: enp2s0 NIC Link is Down
[15463.119419] e1000e: enp2s0 NIC Link is Up 1000 Mbps Full Duplex, Flow
Control: Rx/Tx
[15469.155922] e1000e: enp2s0 NIC Link is Up 1000 Mbps Full Duplex, Flow
Control: Rx/Tx
[15648.196579] e1000e: enp2s0 NIC Link is Down
[15651.405310] e1000e: enp2s0 NIC Link is Up 1000 Mbps Full Duplex, Flow
Control: Rx/Tx
[15728.959981] e1000e: enp2s0 NIC Link is Down
[15729.000625] e1000e: enp2s0 NIC Link is Up 1000 Mbps Full Duplex, Flow
Control: Rx/Tx
[15835.132034] e1000e: enp2s0 NIC Link is Down
[15835.185222] e1000e: enp2s0 NIC Link is Up 1000 Mbps Full Duplex, Flow
Control: Rx/Tx
[15839.104020] e1000e: enp2s0 NIC Link is Down
[15839.142346] e1000e: enp2s0 NIC Link is Up 1000 Mbps Full Duplex, Flow
Control: Rx/Tx
[15845.142287] e1000e: enp2s0 NIC Link is Up 1000 Mbps Full Duplex, Flow
Control: Rx/Tx
[16401.940127] e1000e: enp2s0 NIC Link is Down
[16401.945106] e1000e: enp2s0 NIC Link is Up 1000 Mbps Full Duplex, Flow
Control: Rx/Tx
[16408.121843] e1000e: enp2s0 NIC Link is Up 1000 Mbps Full Duplex, Flow
Control: Rx/Tx
[17025.823220] e1000e: enp2s0 NIC Link is Down
[17025.825473] e1000e: enp2s0 NIC Link is Up 1000 Mbps Full Duplex, Flow
Control: Rx/Tx
[17032.100202] e1000e: enp2s0 NIC Link is Up 1000 Mbps Full Duplex, Flow
Control: Rx/Tx
