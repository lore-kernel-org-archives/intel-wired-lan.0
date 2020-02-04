From: Yi Yang =?unknown-8bit?b?5p2o77+9RC3kupHmnI3liqHpm4blm6I=?= <yangyi01@inspur.com>
Date: Tue, 4 Feb 2020 15:34:16 +0000
Subject: [Intel-wired-lan] bad iperf3 tcp performance of Intel 10G NIC when
 MTU is 9000
Message-ID: <6bc9d97b27a24cf79edadedf502caf06@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi, all

We find a very weird issue on Intel 10G NIC, iperf3 tcp performance is good
when MTU is 1500, but it is about one third of the former when MTU is 9000,
anybody knows why it is so, is any solution to it available?

The below is our kernel and ixgbe deriver information:

Ubuntu 16.04 and kernel is updated to 4.15.0-36-generic x86_64
Ixgbe driver version: 5.1.0-k
Firmware version: 0x61c10001

BTW, tso is on.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 3600 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200204/9d1b4744/attachment.p7s>
