From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 31 Mar 2015 00:35:59 -0700
Subject: [Intel-wired-lan] [PATCH net-next v10 5/7] ixgbe: Add
 GET_RSS_KEY command to VF-PF channel commands set
In-Reply-To: <1427740529-9605-6-git-send-email-vladz@cloudius-systems.com>
References: <1427740529-9605-1-git-send-email-vladz@cloudius-systems.com>
 <1427740529-9605-6-git-send-email-vladz@cloudius-systems.com>
Message-ID: <1427787359.2497.113.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2015-03-30 at 21:35 +0300, Vlad Zolotarov wrote:
> For 82599 and x540 VFs and PF share the same RSS Key. Therefore we
> will return
> the same RSS key for all VFs.
> 
> Support for other devices will be added later.
> 
> Signed-off-by: Vlad Zolotarov <vladz@cloudius-systems.com>
> ---
> New in v10:
>    - Return more self-explaining values.
> 
> New in v9:
>    - Reduce the support to 82599 and x540 devices only.
>    - Get rid of registers access in GET_VF_RSS_KEY flow:
>       - Get the RSS HASH Key value from the PF's adapter->rss_key[].
> 
> New in v5:
>    - Use a newly added netdev op to allow/prevent the RSS Hash Key
> querying on a per-VF
>      basis.
> 
> New in v3:
>    - Added a support for x550 devices.
> 
> New in v1 (compared to RFC):
>    - Use "if-else" statement instead of a "switch-case" for a single
> option case
>      (in ixgbe_get_vf_rss_key()).
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h   |  1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 21
> +++++++++++++++++++++
>  2 files changed, 22 insertions(+)

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
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150331/70df4a9b/attachment.asc>
