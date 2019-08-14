From: Jay Fang <f.fangjian@huawei.com>
Date: Wed, 14 Aug 2019 10:23:07 +0800
Subject: [Intel-wired-lan] [ixgbe] Is this a bug? When i do "echo 0 >
 srivo_numvfs" and then the driver print "failed to kill vid 0081/0 for
 device eth15"
Message-ID: <d90328f7-68b7-6536-d9ca-93323c706602@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,
When i do "echo 0 > srivo_numvfs" and then the driver print "failed to
kill vid 0081/0 for device eth10". Does Anyone know about this?

The log is as below:
root:/sys/devices/pci0000:80/0000:80:04.0/0000:82:00.0$ uname -a
Linux (none) 4.19.36-g4ce0944 #1 SMP PREEMPT Mon Aug 12 16:52:59 HKT 2019 aarch64 GNU/Linux
root:/sys/devices/pci0000:80/0000:80:04.0/0000:82:00.0$ ifconfig eth10 192.168.1.79
[  691.077904] ixgbevf 0000:82:10.0: NIC Link is Up 10 Gbps
[  691.079534] IPv6: ADDRCONF(NETDEV_UP): eth10: link is not ready
[  691.089090] 8021q: adding VLAN 0 to HW filter on device eth10
[  691.095377] IPv6: ADDRCONF(NETDEV_CHANGE): eth10: link becomes ready
root:/sys/devices/pci0000:80/0000:80:04.0/0000:82:00.0$ echo 0 > sriov_numvfs
[  702.758155] failed to kill vid 0081/0 for device eth10
[  702.848257] iommu: Removing device 0000:82:10.0 from group 44
[  703.980171] ixgbe 0000:82:00.0: removed PHC on eth6
[  704.049475] ixgbe 0000:81:00.0 eth4: NIC Link is Down
[  704.051497] ixgbe 0000:82:00.0: Multiqueue Enabled: Rx Queue count = 63, Tx Queue count = 63 XDP Queue count = 0
[  704.382823] ixgbe 0000:82:00.0: registered PHC device on eth6



Best Regards,
Jay

