From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 26 Jul 2016 10:53:55 -0700
Subject: [Intel-wired-lan] [PATCH net-next 3/2] e1000e: convert systim
 overflow check to use flags2
In-Reply-To: <1469554746-410-1-git-send-email-jarod@redhat.com>
References: <20160725105648.00000dda@unknown>
 <1469554746-410-1-git-send-email-jarod@redhat.com>
Message-ID: <1469555635.2851.10.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-07-26 at 13:39 -0400, Jarod Wilson wrote:
> Per Jesse Brandeburg, e1000e should be using flags for this sort of
> thing.
> 
> Littering functional code with device-specific checks is much messier
> than
> simply checking a flag, and having device-specific init set flags as
> needed.
> There are probably a number of other cases in the e1000e code that
> could/should be converted similarly.
> 
> At present, this patch is a follow-up to the previously submitted 2
> patches, but I can redo the series to omit the conversion to a switch
> entirely, if so desired.
> 
> Suggested-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> CC: Jesse Brandeburg <jesse.brandeburg@intel.com>
> CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> CC: intel-wired-lan at lists.osuosl.org
> CC: netdev at vger.kernel.org
> Signed-off-by: Jarod Wilson <jarod@redhat.com>
> ---
> ?drivers/net/ethernet/intel/e1000e/82571.c?? |? 6 ++++--
> ?drivers/net/ethernet/intel/e1000e/e1000.h?? |? 1 +
> ?drivers/net/ethernet/intel/e1000e/ich8lan.c |? 3 ++-
> ?drivers/net/ethernet/intel/e1000e/netdev.c? | 10 ++--------
> ?4 files changed, 9 insertions(+), 11 deletions(-)

This generates a compile issue, so I will be dropping this patch and will
await an update.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160726/3055a5ca/attachment-0001.asc>
