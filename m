From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 30 Mar 2015 16:36:46 -0700
Subject: [Intel-wired-lan] [PATCH net-next v3 1/2] ixgbe: Refactor the
 RSS configuration code.
In-Reply-To: <1427739538-1038-2-git-send-email-vladz@cloudius-systems.com>
References: <1427739538-1038-1-git-send-email-vladz@cloudius-systems.com>
 <1427739538-1038-2-git-send-email-vladz@cloudius-systems.com>
Message-ID: <1427758606.2497.100.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2015-03-30 at 21:18 +0300, Vlad Zolotarov wrote:
> This patch is a preparation for enablement of ethtool RSS indirection
> table
> and hash key querying. We don't want to read registers every time the
> RSS info
> is queried. Therefore we will store its current content in the
> arrays in the adapter struct and will read it from there (instead of
> from
> registers) when requested.
> 
> Will change the code that writes the indirection table and hash key
> into the HW registers
> to take its content from these arrays. This will also simplify the
> indirection
> table updating ethtool callback implementation in the future.
> 
> Signed-off-by: Vlad Zolotarov <vladz@cloudius-systems.com>
> ---
> New in v3:
>    - Fix the byte ordering in RETA storing.
> 
> New in v2:
>    - Some styling fixes.
>    - Moved macros definitions from ixgbe_type.h to ixgbe.h.
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   9 ++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 147
> ++++++++++++++++++--------
>  2 files changed, 112 insertions(+), 44 deletions(-)

Thanks Vlad, I have added your patch to my queue.
-- 
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150330/2c326b1a/attachment.asc>
