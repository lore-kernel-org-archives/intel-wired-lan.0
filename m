From: Gangfeng Huang <gangfeng.huang@ni.com>
Date: Wed, 30 Dec 2015 05:30:48 +0000
Subject: [Intel-wired-lan] [PATCH next-queue 1/3] igb: Enable the
 ethtool interface fo Rx filter
In-Reply-To: <1451449682.3348.26.camel@intel.com>
References: <1451029174-32312-1-git-send-email-gangfeng.huang@ni.com>
 <1451029174-32312-2-git-send-email-gangfeng.huang@ni.com>
 <1451449682.3348.26.camel@intel.com>
Message-ID: <DM2PR0401MB09907CBA34C5529B8584EA6BECFD0@DM2PR0401MB0990.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jeff,

I have found the reason why my patch is  failed:  I send the patch in Dec.25 and there are many commit in Dec.29.  I will recreate the patches and send it to you as soon as possible.

Thanks

-----Original Message-----
From: Jeff Kirsher [mailto:jeffrey.t.kirsher at intel.com] 
Sent: 2015?12?30? 12:28
To: Gangfeng Huang <gangfeng.huang@ni.com>; intel-wired-lan at lists.osuosl.org
Cc: Ruhao Gao <ruhao.gao@ni.com>
Subject: Re: [Intel-wired-lan] [PATCH next-queue 1/3] igb: Enable the ethtool interface fo Rx filter

On Fri, 2015-12-25 at 15:39 +0800, Gangfeng wrote:
> From: Gangfeng Huang <gangfeng.huang@ni.com>
> 
> This patch is meant to allow for nfc to insert and remove Rx filter by 
> ethtool. Ethtool interface has it's own rules manager
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

This is getting ridiculous, this is not applying cleaning still.
Are you checking out the dev-queue branch before rebasing your patches?

Here is what I get when I attempt to apply your patch by hand:
[20:15:07 @jtkirshe-linux:next-queue]$ patch -p1 <.apply/1-3-igb- Enable-the-ethtool-interface-fo-Rx-filter.patch
patching file drivers/net/ethernet/intel/igb/igb.h
Hunk #1 succeeded at 353 (offset 5 lines).
Hunk #2 FAILED at 478.
Hunk #3 succeeded at 612 (offset 15 lines).
1 out of 3 hunks FAILED -- saving rejects to file drivers/net/ethernet/intel/igb/igb.h.rej
patching file drivers/net/ethernet/intel/igb/igb_ethtool.c
Hunk #1 succeeded at 2607 (offset 176 lines).
Hunk #2 succeeded at 2702 (offset 176 lines).
Hunk #3 succeeded at 2826 (offset 176 lines).
Hunk #4 succeeded at 2971 (offset 176 lines).
patching file drivers/net/ethernet/intel/igb/igb_main.c
Hunk #1 succeeded at 188 with fuzz 2 (offset 12 lines).
Hunk #2 succeeded at 1636 (offset 24 lines).
Hunk #3 succeeded at 2085 (offset 27 lines).
Hunk #4 succeeded at 2436 (offset 46 lines).
Hunk #5 FAILED at 3004.
Hunk #6 succeeded at 3259 (offset 69 lines).
Hunk #7 FAILED@8143.
2 out of 7 hunks FAILED -- saving rejects to file drivers/net/ethernet/intel/igb/igb_main.c.rej
