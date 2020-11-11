From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Date: Wed, 11 Nov 2020 02:10:27 +0000
Subject: [Intel-wired-lan] [4.9] Security fixes (pinctrl, i40e, geneve)
Message-ID: <add9899fca821cbe47025c7710ebb63e9c16597c.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Here are backports of some fixes to the 4.9 stable branch.

I wasn't able to test the pinctrl fix (no idea how to reproduce it).

I wasn't able to test the i40e changes (no hardware and no reproducer
available).

I tested the geneve fix with libreswan as (roughly) described in the
commit message.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
-------------- next part --------------
A non-text attachment was scrubbed...
Name: security-4.9.mbox
Type: application/mbox
Size: 18015 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201111/3cfae26c/attachment.mbox>
