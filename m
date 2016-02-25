From: Gangfeng Huang <gangfeng.huang@ni.com>
Date: Thu, 25 Feb 2016 02:52:12 +0000
Subject: [Intel-wired-lan] [PATCH 1/3] igb: Enable the ethtool interface
 fo Rx filter
In-Reply-To: <1456345773.2808.8.camel@intel.com>
References: <1456304783-15019-1-git-send-email-gangfeng.huang@ni.com>
 <1456345773.2808.8.camel@intel.com>
Message-ID: <DM2PR0401MB099012CEA70D5EF0B98A5969ECA60@DM2PR0401MB0990.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jeff,

Thank you very for the comments and suggestion,  Because I am not vary clear about the process of submit commit,  I directly fix arron's comments in my yesterday's patch.  I will recreate this patches to update the description and  fix aaron's comments in a separate patch.

-----Original Message-----
From: Jeff Kirsher [mailto:jeffrey.t.kirsher at intel.com] 
Sent: 2016?2?25? 4:30
To: Gangfeng Huang <gangfeng.huang@ni.com>; intel-wired-lan at lists.osuosl.org
Cc: Ruhao Gao <ruhao.gao@ni.com>; John Ronciak <john.ronciak@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH 1/3] igb: Enable the ethtool interface fo Rx filter

On Wed, 2016-02-24 at 17:06 +0800, Gangfeng wrote:
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
> ?drivers/net/ethernet/intel/igb/igb_main.c??? |?? 45 ++++++
> ?3 files changed, 269 insertions(+)

What does NFC mean? ?It is proper etiquette to spell out all acronyms before using them, especially when they are not universally known.

Did you address Aaron Brown questions and concerns? ?I do not see any change log to this series of patches, so I do not think you changed anything from the first time you submitted it. ?I rejected this the first time around because of the questions and concerns Aaron brought up, so if you are going to ignore Aaron, you might as well forget about getting these changes into the kernel.

Also for the amount of changes you are making to the igb, we will need a clearly defined justification as to why this is needed. ?Your sparse patch description needs more information to help us understand why we need these changes.
