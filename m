From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 31 Mar 2015 00:35:11 -0700
Subject: [Intel-wired-lan] [PATCH net-next v10 2/7] ixgbe: Add a new
 netdev op to allow/prevent a VF from querying an RSS info
In-Reply-To: <1427740529-9605-3-git-send-email-vladz@cloudius-systems.com>
References: <1427740529-9605-1-git-send-email-vladz@cloudius-systems.com>
 <1427740529-9605-3-git-send-email-vladz@cloudius-systems.com>
Message-ID: <1427787311.2497.110.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2015-03-30 at 21:35 +0300, Vlad Zolotarov wrote:
> Implements the new netdev op to allow user to enable/disable the
> ability
> of a specific VF to query its RSS Indirection Table and an RSS Hash
> Key.
> 
> This patch limits the new feature support to 82599 and x540 devices
> only.
> Support for other devices will be added later.
> 
> Signed-off-by: Vlad Zolotarov <vladz@cloudius-systems.com>
> ---
> New in v10:
>    - United the for-each-VF loops in __ixgbe_enable_sriov() and
>      ixgbe_configure_virtualization().
>    - Use the EOPNOTSUPP error code instead of EPERM when operation is
>      not supported.
> 
> New in v9:
>    - Reduce the support to 82599 and x540 devices only.
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h       |  1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  5 ++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 34
> ++++++++++++++++++++++++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h |  2 ++
>  4 files changed, 40 insertions(+), 2 deletions(-)

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
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150331/9e72c2d8/attachment.asc>
