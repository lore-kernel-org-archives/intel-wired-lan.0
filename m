From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 24 Feb 2016 12:29:33 -0800
Subject: [Intel-wired-lan] [PATCH 1/3] igb: Enable the ethtool interface
 fo Rx filter
In-Reply-To: <1456304783-15019-1-git-send-email-gangfeng.huang@ni.com>
References: <1456304783-15019-1-git-send-email-gangfeng.huang@ni.com>
Message-ID: <1456345773.2808.8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-02-24 at 17:06 +0800, Gangfeng wrote:
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
> ?drivers/net/ethernet/intel/igb/igb_main.c??? |?? 45 ++++++
> ?3 files changed, 269 insertions(+)

What does NFC mean? ?It is proper etiquette to spell out all acronyms
before using them, especially when they are not universally known.

Did you address Aaron Brown questions and concerns? ?I do not see any
change log to this series of patches, so I do not think you changed
anything from the first time you submitted it. ?I rejected this the
first time around because of the questions and concerns Aaron brought
up, so if you are going to ignore Aaron, you might as well forget about
getting these changes into the kernel.

Also for the amount of changes you are making to the igb, we will need
a clearly defined justification as to why this is needed. ?Your sparse
patch description needs more information to help us understand why we
need these changes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160224/17739957/attachment.asc>
