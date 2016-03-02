From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 02 Mar 2016 15:30:42 -0800
Subject: [Intel-wired-lan] [PATCH 1/4] igb: Enable the ethtool interface
 fo RX nfc filter
In-Reply-To: <1456378503-19463-1-git-send-email-gangfeng.huang@ni.com>
References: <1456378503-19463-1-git-send-email-gangfeng.huang@ni.com>
Message-ID: <1456961442.2822.28.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2016-02-25 at 13:35 +0800, Gangfeng wrote:
> From: Gangfeng Huang <gangfeng.huang@ni.com>
> 
> This patch is meant to allow for RX flow classification to insert and
> remove Rx filter by ethtool. Ethtool interface has it's own rules
> manager
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

This patch does not apply, because it is based on a igb driver that has
your character device support in the driver (which was rejected by
David Miller, and others).

Also you removed the reference to NFC in the patch description, so you
could avoid actually defining what you mean by NFC. :-( ?But you forgot
to remove the reference from the title of the patch.

Also you refer to "NFC" in your patch, but you never define what NFC
stands for. ?So if you seriously want these changes in the igb driver,
then you will have to make the following changes to this series:

? 1- Make sure they apply cleanly to my next-queue tree (dev-queue
branch) before sending them out for review and testing
? 2- Define what NFC stands for in the patch description BEFORE you use
the NFC acronym
? 3- Use proper versioning of your patch series. ?This is at least the
third time you have sent out this series with changes, yet based on the
series title, it would appear that this is the first time you sent it
:-( Learn to use 'git format-patch -v 4 --cover-letter' options.
? 4- Provide a cover-letter with the detailed change history of the
patch set as well as a lengthy description of why this patch series is
needed for the igb driver

With ANY of the above missing from your next patch series submission
will be cause for the series to be dropped without any question from
the patch queue.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160302/9cb70983/attachment.asc>
