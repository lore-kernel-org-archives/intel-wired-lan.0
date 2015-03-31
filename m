From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 31 Mar 2015 00:36:28 -0700
Subject: [Intel-wired-lan] [PATCH net-next v10 7/7] ixgbevf: Add the
 appropriate ethtool ops to query RSS indirection table and key
In-Reply-To: <1427740529-9605-8-git-send-email-vladz@cloudius-systems.com>
References: <1427740529-9605-1-git-send-email-vladz@cloudius-systems.com>
 <1427740529-9605-8-git-send-email-vladz@cloudius-systems.com>
Message-ID: <1427787388.2497.115.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2015-03-30 at 21:35 +0300, Vlad Zolotarov wrote:
> Added get_rxfh_indir_size, get_rxfh_key_size and get_rxfh ethtool_ops
> callbacks
> implementations.
> 
> This enables the ethtool's "-x" and "--show-rxfh[-indir]" options for
> VF devices.
> 
> This patch adds the support for 82599 and x540 devices only. Support
> for other
> devices will be added later.
> 
> Signed-off-by: Vlad Zolotarov <vladz@cloudius-systems.com>
> ---
> New in v10:
>    - Move the mailbox locks outside the vf.c functions.
>    - Use IXGBEVF_82599_RETA_SIZE macro.
> 
> New in v9:
>    - Use IXGBEVF_RSS_HASH_KEY_SIZE macro.
> 
> New in v6:
>    - Added a required get_rxnfc callback to ixgbevf_ethtool_ops.
> 
> New in v4:
>    - Removed not needed braces in if-statement in
> ixgbevf_get_rxfh_indir_size().
> 
> New in v3:
>    - Added a proper support for x550 devices: return the correct
> redirection table size.
> 
> New in v2:
>    - Added a detailed description to the patch.
> ---
>  drivers/net/ethernet/intel/ixgbevf/ethtool.c | 69
> ++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)

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
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150331/35d65e19/attachment.asc>
