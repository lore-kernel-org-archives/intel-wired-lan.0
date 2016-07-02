From: Patrick McLean <patrickm@gaikai.com>
Date: Fri, 1 Jul 2016 18:31:15 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: always initialize setup_fc
Message-ID: <CAE2NFgXEYU0mJDs638JYzykUSz4PCme6kecXVjWesH=0ySxZVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In ixgbe_init_mac_link_ops_X550em, the code has a special case for
backplane media type, but does not fall through to the default case, so the
setup_fc never gets initialized. This causes a panic when it later tries to
set up the card, and the kernel dereferences the null pointer.

This patch lets the the function fall through, which initialized setup_fc
properly.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160701/09bb2ecb/attachment.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: ixgbe-x550-always-initialize-setup_fc.patch
Type: text/x-patch
Size: 559 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160701/09bb2ecb/attachment.bin>
