From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 08 Apr 2015 19:58:22 -0700
Subject: [Intel-wired-lan] [PATCH] e1000e: Do not allow CRC stripping to
 be disabled on 82579 w/ jumbo frames
In-Reply-To: <20150409013554.3231.10427.stgit@ahduyck-vm-fedora22>
References: <20150409013554.3231.10427.stgit@ahduyck-vm-fedora22>
Message-ID: <1428548302.2729.9.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2015-04-08 at 18:37 -0700, Alexander Duyck wrote:
> The driver wasn't allowing jumbo frames to be enabled when CRC
> stripping
> was disabled, however it was allowing CRC stripping to be disabled
> while
> jumbo frames were enabled.  This fixes that by making it so that the
> NETIF_F_RXFCS flag cannot be set when jumbo frames are enabled on
> 82579 and
> newer parts.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Thanks Alex, I will add your patch to my queue.
-- 
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150408/40809610/attachment.asc>
