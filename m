From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Date: Wed, 11 Nov 2020 23:43:56 +0000
Subject: [Intel-wired-lan] [4.4] Security fixes (pinctrl, i40e, geneve)
Message-ID: <f5e2e87fb1a9613b161e63cf5504cc375e095dbc.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Here are backports of some fixes to the 4.4 stable branch.

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
Name: security-4.4.mbox
Type: application/mbox
Size: 12342 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201111/1d13b8f7/attachment.mbox>
