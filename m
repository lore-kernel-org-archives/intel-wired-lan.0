From: Martin Zaharinov <micron10@gmail.com>
Date: Sat, 22 Jan 2022 19:35:15 +0200
Subject: [Intel-wired-lan] Fwd: Intel i40e driver problem when is enable
 rx-vlan-filter: on [fixed]
In-Reply-To: <CALidq=UDYtC08Y0v+jsmkuro16CgBggW=B1PHmhn=6NyTN+G=Q@mail.gmail.com>
References: <CALidq=UDYtC08Y0v+jsmkuro16CgBggW=B1PHmhn=6NyTN+G=Q@mail.gmail.com>
Message-ID: <CALidq=UTiDv6V0psq0CxJ8vqmEC8JxjAtY=u88oKcahNbB342w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Intel Team

We found one big problem(Bug) in intel i40e driver .

test kernel is 5.16.2
Card : INtel XL710 (AOC-S40G-i2Q (Supermicro))

this is ethtool -i :

driver: i40e
version: 5.16.2
firmware-version: 7.20 0x80008322 1.2585.0
expansion-rom-version:
bus-info: 0000:02:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

Problem is this :

[   42.267788] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   42.304230] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   42.343222] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   42.383900] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   42.424674] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   42.465541] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   42.507650] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   42.551789] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   42.598153] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   42.645146] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   42.693241] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   42.741304] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   42.789719] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   42.839720] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   42.890856] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   42.943083] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   43.058643] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   43.110952] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   43.163266] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   43.215573] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   43.267887] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   43.320205] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   43.372544] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   43.424854] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   43.477162] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   43.529498] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   43.581811] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   43.634122] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   43.686429] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   43.738745] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   43.791061] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on
[   43.908556] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC, forcing
overflow promiscuous on PF
[   43.960581] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC, forcing
overflow promiscuous on PF

......

[  233.152055] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC, forcing
overflow promiscuous on PF
[  233.205430] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC, forcing
overflow promiscuous on PF
[  233.258777] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC, forcing
overflow promiscuous on PF
[  233.312141] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC, forcing
overflow promiscuous on PF
[  233.365493] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC, forcing
overflow promiscuous on PF
[  233.420367] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC, forcing
overflow promiscuous on PF
[  233.473951] i40e 0000:02:00.0: Error I40E_AQ_RC_ENOSPC adding RX
filters on PF, promiscuous mode forced on


Problem is flood dmesg and networking stop work on this time of message .

do you have any idea how to fix or patch i40e driver to fix this problem.

on machine is configured this interface only :

1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
group default qlen 10000
    link/ether 0c:c4:7a:19:70:18 brd ff:ff:ff:ff:ff:ff
3: eth1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group
default qlen 1000
    link/ether 0c:c4:7a:19:70:19 brd ff:ff:ff:ff:ff:ff
4: eth0.0101 at eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc
noqueue state UP group default qlen 1000
    link/ether 0c:c4:7a:19:70:18 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.2/27 scope global eth0.0101
       valid_lft forever preferred_lft forever

Normaly problem stop when make this :

ethtool -K eth0 rx-vlan-filter off
Actual changes:
rx-vlan-filter: on [requested off]
Could not change any device features

But in this card this options is hard set on ON and i not found
options to disable.


Best regards,
Martin
