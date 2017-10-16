From: Avi Cohen (A) <avi.cohen@huawei.com>
Date: Mon, 16 Oct 2017 07:24:22 +0000
Subject: [Intel-wired-lan] 6 port NIC
Message-ID: <B84047ECBD981D4B93EAE5A6245AA361013EDADC@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,
I'm looking for a  6-port nic - each port is 10G -    for a total of 60Gbps,   (or 2 * quad NIC) 
 other requirements:
 - a 'L2 switch' on top  all these 6 ports  - for example if  a packet is received on port 1 with a dst MAC that was learnt on port 3 then the packet should be sent to port 3 (other than sent to the host)
 - SR-IOV coexistence
 - Optional - IPsec offload

Best Regards
Avi  
 
