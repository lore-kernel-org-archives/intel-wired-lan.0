From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 02 Mar 2016 15:45:30 -0800
Subject: [Intel-wired-lan] [PATCH v3] fm10k: cleanup fm10k stats and
 remove debug-statistics
In-Reply-To: <1456951531-15783-1-git-send-email-jacob.e.keller@intel.com>
References: <1456951531-15783-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1456962330.2822.31.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-03-02 at 12:45 -0800, Jacob Keller wrote:
> This change fixes up subtle issues with the current fm10k ethtool
> stats.
> Primarily, support of debug-statistics and per-queue length
> statistics
> is not something the current API can handle. Due to the way that
> ethtool
> works, the number of statistics needs to be static for the life time
> of
> a given device. Our use of debug-statistics does not really allow for
> this, so this patch drops its use.
> 
> Finish this cleanup by reworking the per-queue stats to use the new
> helper functions which reduce the duplicate and error prone code.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> 
> Notes:
> ??? - v3
> ??? * based on comments upstream, make queues static
> ??? * remove debug-statistics support since this can break the
> ethtool API
> ????
> ??? - v4
> ??? * remove extra debug stats strings forgotten in previous rework
> 
> This is based on the fact that the ethtool API cannot really support
> variable statistics lengths.
> 
> ?drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 127 ++++++-------
> ----------
> ?1 file changed, 33 insertions(+), 94 deletions(-)

This patch does not apply cleanly. ?I tried looking to see if I have
the previous patch applied and it does not appear that I do, unless you
changed the patch title (which is not the first time you done something
like this :-()

Looks like a v5 is needed or you let me know what patch this is
replacing in my current tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160302/4f12c62d/attachment.asc>
