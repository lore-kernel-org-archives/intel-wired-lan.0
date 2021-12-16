From: Leonid Bloch <leonidb@asocscloud.com>
Date: Thu, 16 Dec 2021 17:20:21 +0200
Subject: [Intel-wired-lan] PROBLEM: iavf seems not to fully bind to all the
 devices all the time
Message-ID: <dd7b69a4-f509-2712-78e6-53b74519b63d@asocscloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

I have a VM with 3 Intel VF's attached:

# lspci | grep Ethernet
04:00.0 Ethernet controller: VMware VMXNET3 Ethernet Controller (rev 01)
0b:00.0 Ethernet controller: Intel Corporation Ethernet Virtual Function 
700 Series (rev 04)
13:00.0 Ethernet controller: Intel Corporation Ethernet Virtual Function 
700 Series (rev 04)
1b:00.0 Ethernet controller: Intel Corporation Ethernet Virtual Function 
700 Series (rev 04)

But not on every boot or driver load/unload all the VFs are fully 
initialized (some do not appear as network interfaces):

# ip l | sed '/^[0-9]\+:/! d' | bc <<<"$(wc -l) - 2"
3
# rmmod iavf
# modprobe iavf
# ip l | sed '/^[0-9]\+:/! d' | bc <<<"$(wc -l) - 2"
1
# rmmod iavf
# modprobe iavf
# ip l | sed '/^[0-9]\+:/! d' | bc <<<"$(wc -l) - 2"
3

...etc (the number always varies between 3 - all the interfaces, and 1 - 
only one interface, never 0).

The PCI devices which do not appear as network interfaces however, still 
appear as bound to iavf, but somehow not fully:

When all the interfaces appear:
# lshw | grep iavf
configuration: autonegotiation=off broadcast=yes driver=iavf 
driverversion=5.10.78.rt56-1 duplex=full firmware=N/A latency=64 link=no 
multicast=yes
configuration: autonegotiation=off broadcast=yes driver=iavf 
driverversion=5.10.78.rt56-1 duplex=full firmware=N/A latency=64 link=no 
multicast=yes
configuration: autonegotiation=off broadcast=yes driver=iavf 
driverversion=5.10.78.rt56-1 duplex=full firmware=N/A latency=64 link=no 
multicast=yes

When only 2/3 appear:
# lshw | grep iavf
configuration: autonegotiation=off broadcast=yes driver=iavf 
driverversion=5.10.78.rt56-1 duplex=full firmware=N/A latency=64 link=no 
multicast=yes
configuration: driver=iavf latency=64
configuration: autonegotiation=off broadcast=yes driver=iavf 
driverversion=5.10.78.rt56-1 duplex=full firmware=N/A latency=64 link=no 
multicast=yes

There are no apparent errors in dmesg.

The kernels used: 5.15.7, 5.15.3, 5.15.2, 5.10.78, 5.10.56 (the ones I 
tried so far).

Any suggestions?


Thanks,
Leonid.
