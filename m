From: Tal Lubko <tallubko@yahoo.com>
Date: Thu, 25 Mar 2021 09:58:22 +0000 (UTC)
Subject: [Intel-wired-lan] Boot Linux Quickly Including Network on Intel
 Platfirm
References: <695025580.69134.1616666302689.ref@mail.yahoo.com>
Message-ID: <695025580.69134.1616666302689@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Hi

I'm trying to boot Linux and start Ethernet Quickly (up to 3 seconds) on Intel's Whiskey-Lake CRB (8th generation Intel Core) which has i219-LM NIC.
My destained system is embedded system which means I can have customized solution to meet the link time requirement.
I'm not sure yet about 1G/100M connection (I want 1G connection but may be able to use 100M in case it helps to meet the link time requirement).
I may also be able to disable other options (like auto-negotiation, power management, etcetera) if needed.
Later on I'll intergrate this core to another carrier but currently I'm using Intel's CRB for evaluation.

For fast boot I have intergrated Intel's SBL (Slim Boot Loader) on this platform.
With SBL, Linux boots in ~1.7 seconds (from power-up until some user space application).
Ethernet is working (I get ping reply) in ~7.5 seconds (from power-up until ping reply) on 1G connection.
I've also checked how much does it take to bring Ethernet down, back up and pinging and got ~5.7 seconds (on 1G connection).

I wonder if it possible on this CRB with the given NIC and with Intel core NICs in general.
With some Xilinx's SOC and some TI PHY (which has "fast link" capability) we were able to get Ethernet working in less than 2 seconds.

My questions are:
1) Is it possible? Are you familiar with similar projects which reach this goal? Similar projects can be on this platform or another.
2) I will be glad to get some suggestions as how to try and reach my goal.
3) Any other suggestions?

Regards,
Tal

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210325/2eaa8acb/attachment-0001.html>
