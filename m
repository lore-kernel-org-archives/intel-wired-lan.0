From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 31 Mar 2015 00:36:13 -0700
Subject: [Intel-wired-lan] [PATCH net-next v10 6/7] ixgbevf: Add RSS Key
	query code
In-Reply-To: <1427740529-9605-7-git-send-email-vladz@cloudius-systems.com>
References: <1427740529-9605-1-git-send-email-vladz@cloudius-systems.com>
 <1427740529-9605-7-git-send-email-vladz@cloudius-systems.com>
Message-ID: <1427787373.2497.114.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2015-03-30 at 21:35 +0300, Vlad Zolotarov wrote:
> Add the ixgbevf_get_rss_key() function that queries the PF for an RSS
> Random Key
> using a new VF-PF channel IXGBE_VF_GET_RSS_KEY command.
> 
> This patch adds the support for 82599 and x540 devices only. Support
> for other
> devices will be added later.
> 
> Signed-off-by: Vlad Zolotarov <vladz@cloudius-systems.com>
> ---
> New in v10:
>    - Expose the _locked function in the vf.h interface according
>      to the current ixgbevf layering model.
>    - Return EOPNOTSUPP in cases then operation is not supported.
> 
> New in v9:
>    - Reduce the support to 82599 and x540 devices only.
>    - Added IXGBEVF_RSS_HASH_KEY_SIZE macro.
> 
> New in v8:
>    - Protect a mailbox access.
> 
> New in v6:
>    - Return a proper return code when an operation is blocked by PF.
> 
> New in v2:
>    - Added a more detailed patch description.
> 
> New in v1 (compared to RFC):
>    - Use "if-else" statement instead of a "switch-case" for a single
> option case
>      (in ixgbevf_get_rss_key()).
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h |  1 +
>  drivers/net/ethernet/intel/ixgbevf/mbx.h     |  1 +
>  drivers/net/ethernet/intel/ixgbevf/vf.c      | 54
> ++++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/ixgbevf/vf.h      |  1 +
>  4 files changed, 57 insertions(+)

Thanks Vlad, applied to my queue.
-- 
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150331/4fd30e85/attachment.asc>
