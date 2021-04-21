From: Liwei Song <liwei.song@windriver.com>
Date: Wed, 21 Apr 2021 10:29:37 +0800
Subject: [Intel-wired-lan] [PATCH] ice: set the value of global config
 lock timeout longer
In-Reply-To: <7d85412de58342e4469efdfdc6196925ce770993.camel@intel.com>
References: <20210419093106.6487-1-liwei.song@windriver.com>
 <7d85412de58342e4469efdfdc6196925ce770993.camel@intel.com>
Message-ID: <fca32ba9-ad20-0994-de7c-b3bf8425a07b@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 4/21/21 06:48, Nguyen, Anthony L wrote:
> On Mon, 2021-04-19 at 17:31 +0800, Liwei Song wrote:
>> It may need hold Global Config Lock a longer time when download DDP
>> package file, extend the timeout value to 5000ms to ensure that
>> download can be finished before other AQ command got time to run,
>> this will fix the issue below when probe the device, 5000ms is a test
>> value that work with both Backplane and BreakoutCable NVM image:
>>
>> ice 0000:f4:00.0: VSI 12 failed lan queue config, error ICE_ERR_CFG
>> ice 0000:f4:00.0: Failed to delete VSI 12 in FW - error:
>> ICE_ERR_AQ_TIMEOUT
>> ice 0000:f4:00.0: probe failed due to setup PF switch: -12
>> ice: probe of 0000:f4:00.0 failed with error -12
> 
> Hi Liwei,
> 
> We haven't encountered this issue before. Can you provide some more
> info on your setup or how you're coming across this issue?
> 
> Perhaps, lspci output and some more of the dmesg log? We'd like to try
> to reproduce this so we can invesitgate it further.

Hi Tony,

My board is Idaville ICE-D platform, it can be reproduced when
there is no QSFP Transceiver Module setup on it, it is not
happened on each "modprobe ice", about 1/8 rate to got that
error message when I loop run "modprobe -r ice && modprobe ice".
the port type is Backplane, and I haven't reproduce
it with Breakout mode. 

In Backplane mode:
root at intel-x86-64:~# time modprobe ice

real	0m25.990s
user	0m0.000s
sys	0m0.015s


In Breakout mode(don't have that issue)
root at intel-x86-64:~# time modprobe ice

real    0m1.323s
user    0m0.000s
sys     0m0.022s


The whole message when probe ice:

ice: Intel(R) Ethernet Connection E800 Series Linux Driver
ice: Copyright (c) 2018, Intel Corporation.
ice 0000:f4:00.0: The DDP package was successfully loaded: ICE OS Default Package version 1.3.16.0
ice 0000:f4:00.0: VSI 12 failed lan queue config, error ICE_ERR_CFG
ice 0000:f4:00.0: Failed to delete VSI 12 in FW - error: ICE_ERR_AQ_TIMEOUT
ice 0000:f4:00.0: probe failed due to setup PF switch: -12
ice: probe of 0000:f4:00.0 failed with error -12
ice 0000:f4:00.1: The DDP package was successfully loaded: ICE OS Default Package version 1.3.16.0
ice 0000:f4:00.1: DCB is enabled in the hardware, max number of TCs supported on this port are 8
ice 0000:f4:00.1: FW LLDP is disabled, DCBx/LLDP in SW mode.
ice 0000:f4:00.1: Commit DCB Configuration to the hardware
ice 0000:f4:00.1: 2.000 Gb/s available PCIe bandwidth (2.5 GT/s x1 link)
ice 0000:f4:00.2: DDP package already present on device: ICE OS Default Package version 1.3.16.0
ice 0000:f4:00.2: DCB is enabled in the hardware, max number of TCs supported on this port are 8
ice 0000:f4:00.2: FW LLDP is disabled, DCBx/LLDP in SW mode.
ice 0000:f4:00.2: Commit DCB Configuration to the hardware
ice 0000:f4:00.2: 2.000 Gb/s available PCIe bandwidth (2.5 GT/s x1 link)
ice 0000:f4:00.3: DDP package already present on device: ICE OS Default Package version 1.3.16.0
ice 0000:f4:00.3: DCB is enabled in the hardware, max number of TCs supported on this port are 8
ice 0000:f4:00.3: FW LLDP is disabled, DCBx/LLDP in SW mode.
ice 0000:f4:00.3: Commit DCB Configuration to the hardware
ice 0000:f4:00.3: 2.000 Gb/s available PCIe bandwidth (2.5 GT/s x1 link)



lspci:

f4:00.0 Ethernet controller [0200]: Intel Corporation Device [8086:124c]
	Subsystem: Intel Corporation Device [8086:0000]
	Flags: bus master, fast devsel, latency 0, IRQ 16, NUMA node 0
	Memory at 22ff0000000 (64-bit, prefetchable) [size=128M]
	Memory at 22ffc030000 (64-bit, prefetchable) [size=64K]
	Expansion ROM at d8000000 [disabled] [size=1M]
	Capabilities: [40] Power Management version 3
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
	Capabilities: [70] MSI-X: Enable+ Count=512 Masked-
	Capabilities: [a0] Express Endpoint, MSI 00
	Capabilities: [e0] Vital Product Data
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [148] Alternative Routing-ID Interpretation (ARI)
	Capabilities: [160] Single Root I/O Virtualization (SR-IOV)
	Capabilities: [1a0] Transaction Processing Hints
	Capabilities: [1b0] Access Control Services
	Kernel driver in use: ice
	Kernel modules: ice


ethtool info:

root at intel-x86-64:~# ethtool eth1
Settings for eth1:
	Supported ports: [ ]
	Supported link modes:   1000baseKX/Full 
	                        10000baseKR/Full 
	Supported pause frame use: Symmetric
	Supports auto-negotiation: Yes
	Supported FEC modes: None
	Advertised link modes:  1000baseKX/Full 
	                        10000baseKR/Full 
	Advertised pause frame use: No
	Advertised auto-negotiation: Yes
	Advertised FEC modes: None
	Speed: Unknown!
	Duplex: Unknown! (255)
	Port: Other
	PHYAD: 0
	Transceiver: internal
	Auto-negotiation: off
	Supports Wake-on: g
	Wake-on: d
	Current message level: 0x00000007 (7)
			       drv probe link
	Link detected: no


root at intel-x86-64:~# ethtool -i eth1
driver: ice
version: 5.12.0-rc5+
firmware-version: 1.24 0x80005e12 1.2817.0
expansion-rom-version: 
bus-info: 0000:f4:00.0
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

Thanks,
Liwei.

> 
> Thanks,
> Tony
> 
>> Signed-off-by: Liwei Song <liwei.song@windriver.com>
>> ---
>>  drivers/net/ethernet/intel/ice/ice_type.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_type.h
>> b/drivers/net/ethernet/intel/ice/ice_type.h
>> index 266036b7a49a..8a90c47e337d 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_type.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_type.h
>> @@ -63,7 +63,7 @@ enum ice_aq_res_ids {
>>  /* FW update timeout definitions are in milliseconds */
>>  #define ICE_NVM_TIMEOUT			180000
>>  #define ICE_CHANGE_LOCK_TIMEOUT		1000
>> -#define ICE_GLOBAL_CFG_LOCK_TIMEOUT	3000
>> +#define ICE_GLOBAL_CFG_LOCK_TIMEOUT	5000
>>  
>>  enum ice_aq_res_access_type {
>>  	ICE_RES_READ = 1,
