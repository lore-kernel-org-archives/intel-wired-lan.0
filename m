From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 24 Dec 2015 14:02:43 -0800
Subject: [Intel-wired-lan] [next PATCH 1/3] igb: Enable the ethtool
 interface fo Rx filter
In-Reply-To: <1450925102-28992-2-git-send-email-gangfeng.huang@ni.com>
References: <1450925102-28992-1-git-send-email-gangfeng.huang@ni.com>
 <1450925102-28992-2-git-send-email-gangfeng.huang@ni.com>
Message-ID: <1450994563.3316.42.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2015-12-24 at 10:45 +0800, Gangfeng wrote:
> From: Gangfeng Huang <gangfeng.huang@ni.com>
> 
> This patch is meant to allow for nfc to insert and remove Rx filter
> by ethtool. Ethtool interface has it's own rules manager
> 
> Show all filters:
> $ ethtool -n eth0
> 4 RX rings available
> Total 2 rules
> 
> Signed-off-by: Ruhao Gao <ruhao.gao@ni.com>
> Signed-off-by: Gangfeng Huang <gangfeng.huang@ni.com>
> ---
> ?drivers/net/ethernet/intel/igb/igb.h???????? |?? 31 +++++
> ?drivers/net/ethernet/intel/igb/igb_ethtool.c |? 193
> ++++++++++++++++++++++++++
> ?drivers/net/ethernet/intel/igb/igb_main.c??? |?? 57 ++++++++
> ?3 files changed, 281 insertions(+)

Still does not apply cleanly, are you sure you are using the dev-queue
branch of mt next-queue tree?

Here is what I get when I try to apply it by hand:
[13:53:24 @jtkirshe-linux:next-queue]$ patch -p1 <.apply/next-1-3-igb-
Enable-the-ethtool-interface-fo-Rx-filter.patch?
patching file drivers/net/ethernet/intel/igb/igb.h
Hunk #1 succeeded at 353 (offset 5 lines).
Hunk #2 FAILED at 476.
Hunk #3 succeeded at 612 (offset 17 lines).
1 out of 3 hunks FAILED -- saving rejects to file
drivers/net/ethernet/intel/igb/igb.h.rej
patching file drivers/net/ethernet/intel/igb/igb_ethtool.c
Hunk #1 succeeded at 2607 (offset 186 lines).
Hunk #2 succeeded at 2702 (offset 186 lines).
Hunk #3 succeeded at 2826 (offset 186 lines).
Hunk #4 succeeded at 2971 (offset 186 lines).
patching file drivers/net/ethernet/intel/igb/igb_main.c
Hunk #1 succeeded at 188 with fuzz 2 (offset 12 lines).
Hunk #2 succeeded at 1636 (offset 23 lines).
Hunk #3 succeeded at 2085 (offset 26 lines).
Hunk #4 succeeded at 2448 with fuzz 1 (offset 47 lines).
Hunk #5 FAILED at 2996.
Hunk #6 succeeded at 3259 (offset 77 lines).
Hunk #7 FAILED@8135.
2 out of 7 hunks FAILED -- saving rejects to file
drivers/net/ethernet/intel/igb/igb_main.c.rej

Make sure you are running `git branch -b origin/dev-queue` after
cloning my next-queue tree.

Dropping this series and will await an updated series.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151224/22b20ffa/attachment-0001.asc>
