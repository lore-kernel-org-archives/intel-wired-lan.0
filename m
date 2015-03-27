From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 26 Mar 2015 21:15:12 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2 1/2] ixgbe: Refactor the
 RSS configuration code.
In-Reply-To: <1427409886-20261-2-git-send-email-vladz@cloudius-systems.com>
References: <1427409886-20261-1-git-send-email-vladz@cloudius-systems.com>
 <1427409886-20261-2-git-send-email-vladz@cloudius-systems.com>
Message-ID: <1427429712.2497.42.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-03-27 at 00:44 +0200, Vlad Zolotarov wrote:
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
> New in v2:
>    - Some styling fixes.
>    - Moved macros definitions from ixgbe_type.h to ixgbe.h.
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   9 ++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 142
> ++++++++++++++++++--------
>  2 files changed, 108 insertions(+), 43 deletions(-)

I have added this to my queue.
-- 
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150326/e7a556e8/attachment.asc>
