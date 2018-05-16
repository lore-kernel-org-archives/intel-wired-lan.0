From: Joanna Yurdal <jyu@trackman.com>
Date: Wed, 16 May 2018 13:14:11 +0200
Subject: [Intel-wired-lan] [PATCH] igb: Clear TSICR interrupts together with
 ICR
Message-ID: <dc3f47f4-22b2-87d7-3959-9da530efbfe3@trackman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I have been working with the PTP using IGB i210 and the linux driver
can end up in a state where it stops receiving E1000_ICR_TS interrupt.
The ethernet driver works fine but PPS stops and no tx ptp timestamp
can be retrieved. This is caused by not clearing the TS interrupt before enabling igb interrupts in the igb_up function.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-igb-Clear-TSICR-interrupts-together-with-ICR.patch
Type: text/x-patch
Size: 1745 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180516/f2af8b68/attachment-0001.bin>
