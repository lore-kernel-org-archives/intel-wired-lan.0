From: poza@codeaurora.org <poza@codeaurora.org>
Date: Fri, 02 Mar 2018 11:41:53 +0530
Subject: [Intel-wired-lan] SRIOV on Intel x710 fail to get attached both
 at VM creation time and VM runtime
In-Reply-To: <CAKgT0UcXmQ8nkFD9LsNmkU9AHaoC7evb0mB0NFqUC2df_NRy0g@mail.gmail.com>
References: <39dcd27f99192edd77baf4e418443edd@codeaurora.org>
 <2a249cb55b6520cf2a25fbb5903ea56d@codeaurora.org>
 <CAKgT0UcXmQ8nkFD9LsNmkU9AHaoC7evb0mB0NFqUC2df_NRy0g@mail.gmail.com>
Message-ID: <484d2e55bd0961970fadcdf27f00c89c@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2018-03-02 09:10, Alexander Duyck wrote:
> On Thu, Mar 1, 2018 at 8:12 AM,  <poza@codeaurora.org> wrote:
>> + intel-wired-lan at lists.osuosl.org
>> 
>> 
>> On 2018-03-01 21:41, poza at codeaurora.org wrote:
>>> 
>>> Hi All,
>>> 
>>> I am facing the following issue on kernel 4.14.14.
>>> 
>>> Enable SRIOV on Intel x710 card.
>>> echo 32 > /sys/class/net/eth1/device/sriov_numvfs
>>> start net_pool
>>> virsh net-start intel_pool
>>> 
>>> case 1)
>>> attach the VF while creatig VM:
>>> virt-install --accelerate --import --disk /home/disk.img --network
>>> network=intel_pool  --boot uefi --name poza-guest --os-type linux
>>> --os-variant rhel7 --ram 8000 --vcpus 4
>>> 
>>> case 2)
>>> create VM:
>>> virt-install --accelerate --import --disk /home/disk.img --boot uefi
>>> --name poza-guest --os-type linux --os-variant rhel7 --ram 8000
>>> --vcpus 4
>>> attach it:
>>> virsh attach-interface --domain oza-guest --type network --source
>>> intel_pool --target eth1
>>> 
>>> kernel logs:
>>> [44287.825287] i40evf 0000:01:02.0: Unable to send opcode 2 to PF, 
>>> err
>>> I40E_ERR_QUEUE_EMPTY, aq_err OK
>>> [44287.962640] i40e 0000:01:00.0: VF 0 still in reset. Try again.
>>> error: Failed to attach interface
>>> error: Cannot set interface MAC/vlanid to 52:54:00:e9:f1:b5/0 for
>>> ifname eth1 vf 0: Resource temporarily unavailable
>>> 
>>> 
>>> The same use case works with following card with the same kernel
>>> version and rootfs.
>>> Ethernet controller: Mellanox Technologies MT27710 Family [ConnectX-4 
>>> Lx]
>>> 
>>> for details logs please have a look at
>>> https://bugzilla.kernel.org/show_bug.cgi?id=198959
>>> 
>>> Regards,
>>> Oza.
> 
> So the first question that jumps to mind is what is the firmware
> version on the PF, ethtool -i should tell you. Are there any issues
> bringing up the PF and getting it to pass traffic?

yes PF is working fine. and VFs are working fine on host as well.
only problem is attaching them to VM instances.

root at AW-BGLR-REP-32:/sys/class/net/eth0/device# echo 2 > sriov_numvfs

root at AW-BGLR-REP-32:/sys/class/net/eth0/device# ethtool -i eth7
driver: i40evf
version: 3.0.0-k
firmware-version: N/A
expansion-rom-version:
bus-info: 0000:01:02.1
supports-statistics: yes
supports-test: no
supports-eeprom-access: no
supports-register-dump: no
supports-priv-flags: yes
root at AW-BGLR-REP-32:/sys/class/net/eth0/device# ethtool -i eth0
driver: i40e
version: 2.1.14-k
firmware-version: 6.01 0x800034af 1.1747.0
expansion-rom-version:
bus-info: 0000:01:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes


root at AW-BGLR-REP-32:/sys/class/net/eth0/device# udhcpc -i eth0
udhcpc (v1.22.1) started
Sending discover...
Sending select for 10.131.25.80...
Lease of 10.131.25.80 obtained, lease time 86400

root at AW-BGLR-REP-32:/sys/class/net/eth0/device# udhcpc -i eth7
udhcpc (v1.22.1) started
Sending discover...
Sending select for 10.131.25.133...
Lease of 10.131.25.133 obtained, lease time 86400
ip: RTNETLINK answers: File exists

root at AW-BGLR-REP-32:/sys/class/net/eth0/device# ifconfig -a
eth0      Link encap:Ethernet  HWaddr 68:05:ca:38:6f:40
           inet addr:10.131.25.80  Bcast:10.131.31.255  
Mask:255.255.248.0
           inet6 addr: 2002:c023:9c17:d124:6a05:caff:fe38:6f40/64 
Scope:Global
           inet6 addr: fe80::6a05:caff:fe38:6f40/64 Scope:Link
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:979 errors:0 dropped:0 overruns:0 frame:0
           TX packets:129 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:77926 (77.9 KB)  TX bytes:24790 (24.7 KB)

eth1      Link encap:Ethernet  HWaddr 8c:fd:f0:06:a8:d9
           inet addr:10.131.24.219  Bcast:10.131.31.255  
Mask:255.255.248.0
           inet6 addr: fe80::8efd:f0ff:fe06:a8d9/64 Scope:Link
           inet6 addr: 2002:c023:9c17:d124:8efd:f0ff:fe06:a8d9/64 
Scope:Global
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:5176 errors:0 dropped:0 overruns:0 frame:0
           TX packets:13 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:401506 (401.5 KB)  TX bytes:1638 (1.6 KB)
           Interrupt:37

eth2      Link encap:Ethernet  HWaddr 68:05:ca:38:6f:41
           BROADCAST MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

eth3      Link encap:Ethernet  HWaddr 68:05:ca:38:6f:42
           BROADCAST MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

eth4      Link encap:Ethernet  HWaddr 68:05:ca:38:6f:43
           BROADCAST MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

eth5      Link encap:Ethernet  HWaddr 24:8a:07:a4:82:8c
           inet addr:10.131.25.79  Bcast:10.131.31.255  
Mask:255.255.248.0
           inet6 addr: 2002:c023:9c17:d124:268a:7ff:fea4:828c/64 
Scope:Global
           inet6 addr: fe80::268a:7ff:fea4:828c/64 Scope:Link
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:5185 errors:0 dropped:0 overruns:0 frame:0
           TX packets:9 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:381906 (381.9 KB)  TX bytes:1286 (1.2 KB)

eth6      Link encap:Ethernet  HWaddr 24:8a:07:a4:82:8d
           BROADCAST MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

eth7      Link encap:Ethernet  HWaddr fe:fc:48:13:eb:b7
           inet addr:10.131.25.133  Bcast:10.131.31.255  
Mask:255.255.248.0
           inet6 addr: 2002:c023:9c17:d124:fcfc:48ff:fe13:ebb7/64 
Scope:Global
           inet6 addr: fe80::fcfc:48ff:fe13:ebb7/64 Scope:Link
           inet6 addr: 2002:c023:9c17:d124:e564:27b8:5bd3:3eb1/64 
Scope:Global
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:663 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:51828 (51.8 KB)  TX bytes:0 (0.0 B)

eth8      Link encap:Ethernet  HWaddr 1e:0d:31:5f:ec:53
           BROADCAST MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

lo        Link encap:Local Loopback
           inet addr:127.0.0.1  Mask:255.0.0.0
           inet6 addr: ::1/128 Scope:Host
           UP LOOPBACK RUNNING  MTU:65536  Metric:1
           RX packets:614 errors:0 dropped:0 overruns:0 frame:0
           TX packets:614 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:46260 (46.2 KB)  TX bytes:46260 (46.2 KB)



root at AW-BGLR-REP-32:/sys/class/net/eth0/device# lspci
0000:00:00.0 PCI bridge: Airgo Networks, Inc. Device 0401
0000:01:00.0 Ethernet controller: Intel Corporation Ethernet Controller 
X710 for 10GbE SFP+ (rev 01)
0000:01:00.1 Ethernet controller: Intel Corporation Ethernet Controller 
X710 for 10GbE SFP+ (rev 01)
0000:01:00.2 Ethernet controller: Intel Corporation Ethernet Controller 
X710 for 10GbE SFP+ (rev 01)
0000:01:00.3 Ethernet controller: Intel Corporation Ethernet Controller 
X710 for 10GbE SFP+ (rev 01)
0000:01:02.0 Ethernet controller: Intel Corporation XL710/X710 Virtual 
Function (rev 01)
0000:01:02.1 Ethernet controller: Intel Corporation XL710/X710 Virtual 
Function (rev 01)

> 
> Thanks.
> 
> - Alex
