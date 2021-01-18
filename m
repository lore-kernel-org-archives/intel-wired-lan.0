From: Brian Topping <brian.topping@gmail.com>
Date: Mon, 18 Jan 2021 04:19:23 -0700
Subject: [Intel-wired-lan] ixgbe limits on core count
Message-ID: <7F3D0A12-F9FE-4386-9D35-D1C89BD84227@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello experts! 

I?m setting up a machine with two E5-2696 v3 CPUs using XDP on kernel 5.10.6-051006-generic and running into the constraint at https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c#n10136 <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c#n10136>. 

Any advice what the most practical long term solution is?

Short term, I can dial back the number of usable cores. I haven?t dug into the bits to understand if this constraint is based on hardware limits on the card or this was a choice that was made when processors had fewer cores.

Thanks kindly!

Brian
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210118/64ba4e55/attachment.html>
