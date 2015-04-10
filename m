From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 10 Apr 2015 15:55:16 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix IOSF SB access issues
In-Reply-To: <20150410173626.9380.1335.stgit@mdrustad-wks.jf.intel.com>
References: <20150410173626.9380.1335.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <1428706516.2729.126.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-04-10 at 10:36 -0700, Mark D Rustad wrote:
> IOSF is the Intel On-chip System Fabric used in SOCs. IOSF SB is
> the IOSF SideBand message interface. This patch serializes IOSF SB
> access using both phy bits in the SWFW_SEMAPHORE register. It also
> adds a helper function to wait for IOSF SB accesses to complete.
> Use the new function to perform this wait before each access, as
> specified in the datasheet, in addition to using it to wait for
> IOSF SB read/write completion.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>

Thanks Mark, I have applied your patch to my queue.
-- 
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150410/060db0fc/attachment-0001.asc>
