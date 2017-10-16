From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Mon, 16 Oct 2017 16:23:47 +0000
Subject: [Intel-wired-lan] 6 port NIC
In-Reply-To: <B84047ECBD981D4B93EAE5A6245AA361013EDADC@FRAEML521-MBX.china.huawei.com>
References: <B84047ECBD981D4B93EAE5A6245AA361013EDADC@FRAEML521-MBX.china.huawei.com>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD697A3DD1E@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This mailing list is mostly for patches. I'd suggest putting your request in through your factory reps, who will have a lot more options for you than the software engineers usually on this list.

Todd Fujinaka
Software Application Engineer
Datacenter Engineering Group
Intel Corporation
todd.fujinaka at intel.com


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf Of Avi Cohen (A)
Sent: Monday, October 16, 2017 12:24 AM
To: intel-wired-lan@osuosl.org
Subject: [Intel-wired-lan] 6 port NIC

Hi,
I'm looking for a  6-port nic - each port is 10G -    for a total of 60Gbps,   (or 2 * quad NIC) 
 other requirements:
 - a 'L2 switch' on top  all these 6 ports  - for example if  a packet is received on port 1 with a dst MAC that was learnt on port 3 then the packet should be sent to port 3 (other than sent to the host)
 - SR-IOV coexistence
 - Optional - IPsec offload

Best Regards
Avi  
 
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
