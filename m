From: =?unknown-8bit?b?0JDQu9C10LrRgdC10Lkg0JTQtdGA0LrQsNGH0ZHQsg==?= <alexey@gelicon.ru>
Date: Tue, 22 Nov 2016 23:44:54 +0300
Subject: [Intel-wired-lan] i40e filter frames with physical addresses used
	previously.
Message-ID: <fa0abc24-68ad-8fcf-15e1-117211b97ec7@gelicon.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

i40e filter frames with physical addresses used previously.

# uname -a
Linux nas2 4.8.9-gentoo #6 SMP Tue Nov 22 20:35:18 MSK 2016 x86_64 
Intel(R) Core(TM) i7 CPU 860 @ 2.80GHz GenuineIntel GNU/Linux

# ethtool -i net1
driver: i40e
version: 1.6.11-k
firmware-version: 5.04 0x800024c6 0.0.0
bus-info: 0000:06:00.1
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

Testing:

1. SERVER1
ip link add link net1 name net1.21 type vlan id 21
ip link set dev net1.21 up
ip addr del dev net1.21 37.139.86.84/28

5. SERVER 2
ip link add link net1 name net1.21 type vlan id 21
ip link set dev net1.21 up
ip addr del dev net1.21 37.139.86.82/28

2. SERVER 3
ip link add link net1 name net1.21 type vlan id 21
ip link set dev net1.21 up
ip addr del dev net1.21 37.139.86.83/28
ip link set dev net1.21 address 00:1b:fc:6d:9a:77

arping2 37.139.86.84
or
ping 37.139.86.84
Answers are present

3. SERVER1
ip link set dev net1.21 address 00:1b:fc:6d:9a:77
ip link set dev net1.21 address 3c:fd:fe:a0:26:c5

4. SERVER 2
arping2 37.139.86.84
or
ping 37.139.86.84
Answers are present

5. SERVER 3
arping2 37.139.86.84
or
ping 37.139.86.84
The answers are no.

