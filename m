From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 31 Mar 2015 00:34:56 -0700
Subject: [Intel-wired-lan] [PATCH net-next v10 1/7] if_link: Add an
 additional parameter to ifla_vf_info for RSS querying
In-Reply-To: <1427740529-9605-2-git-send-email-vladz@cloudius-systems.com>
References: <1427740529-9605-1-git-send-email-vladz@cloudius-systems.com>
 <1427740529-9605-2-git-send-email-vladz@cloudius-systems.com>
Message-ID: <1427787296.2497.109.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2015-03-30 at 21:35 +0300, Vlad Zolotarov wrote:
> Add configuration setting for drivers to allow/block an RSS
> Redirection Table and
> a Hash Key querying for discrete VFs.
> 
> On some devices VF share the mentioned above information with PF and
> querying it may
> adduce a theoretical security risk. We want to let a system
> administrator to decide if he/she
> wants to take this risk or not.
> 
> Signed-off-by: Vlad Zolotarov <vladz@cloudius-systems.com>
> ---
>  include/linux/if_link.h      |  1 +
>  include/linux/netdevice.h    |  8 ++++++++
>  include/uapi/linux/if_link.h |  8 ++++++++
>  net/core/rtnetlink.c         | 32 ++++++++++++++++++++++++++------
>  4 files changed, 43 insertions(+), 6 deletions(-)

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
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150331/a62de709/attachment.asc>
