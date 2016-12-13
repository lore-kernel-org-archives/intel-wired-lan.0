From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 13 Dec 2016 15:56:14 -0800
Subject: [Intel-wired-lan] [PATCH V6 1/4] ixgbe: Fix issues with EEPROM
 access
In-Reply-To: <148166945619.47119.11718919548789509606.stgit@mdrustad-wks.jf.intel.com>
References: <148166935971.47119.18406082006668540084.stgit@mdrustad-wks.jf.intel.com>
 <148166945619.47119.11718919548789509606.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <1481673374.2406.13.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-12-13 at 14:50 -0800, Mark D Rustad wrote:
> There are two problems with EEPROM access. One is that it needs to
> hold the semaphore until the entire response is read or else the
> response can be corrupted by other firmware accesses. The second
> problem is that acquiring and releasing the semaphore is slow, so
> it should be taken and released once when multiple EEPROM accesses
> will be done.
> 
> Both of these issues can be solved by adding a new function,
> ixgbe_hic_unlocked, to issue firmware commands that will assume
> that the caller has acquired the needed semaphore.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
> ?drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |?? 97 +++++++++++++++
> --------
> ?drivers/net/ethernet/intel/ixgbe/ixgbe_common.h |??? 1?
> ?drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c?? |?? 75 +++++++--------
> ---
> ?3 files changed, 91 insertions(+), 82 deletions(-)

I am unable to apply the first patch of the series:

?Applying .apply/V6-1-4-ixgbe-Fix-issues-with-EEPROM-access.patch ...
Checking for changes in the working directory ... done
Importing patch "V6-1-4-ixgbe-Fix-issues-with-EEPROM-access.patch" ...
error: patch failed: drivers/net/ethernet/intel/ixgbe/ixgbe_common.h:114
error: drivers/net/ethernet/intel/ixgbe/ixgbe_common.h: patch does not
apply
stg import: Diff does not apply cleanly

Looks like, v7 is needed to update the patches so they will actually apply
to my next-queue tree (please make sure you are using my dev-queue branch).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161213/1d0b75ed/attachment.asc>
