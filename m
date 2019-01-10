From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 10 Jan 2019 13:29:45 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix packet loss when updating
 multicast table
In-Reply-To: <1547119741-34056-1-git-send-email-piotrx.skajewski@intel.com>
References: <1547119741-34056-1-git-send-email-piotrx.skajewski@intel.com>
Message-ID: <f1c4dab71d39cecf58706b24d414ef0921fd38dc.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2019-01-10 at 12:29 +0100, Piotr Skajewski wrote:
> This change fixing 2 issues with:
>     - Packet loss when updating the MTA
>     - Multicast packets are received even after leaving the MC group
> 
> Signed-off-by: Piotr Skajewski <piotrx.skajewski@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h        |  1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |  4 ----
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   | 10 +++++-----
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c  | 22 ++++++++-------
> -------
>  4 files changed, 14 insertions(+), 23 deletions(-)

Could you elaborate more in the patch description?  Additional
information that would be useful would be:

- Why was there packet loss when updating the MTA?
- Why were multicast packets received after leaving the MC group

Also this patch should probably be slit into 2 patches, one patch for
the first fix and the second patch for the second fix.  Unless the fix
for both was the same logic change, but it does not appear that these
fixes are related.

As a helpful hint, it is not bad to be very verbose in the patch
description.  That way years from now, when we look back at a change,
we have a good idea of what the problem was and why it occurred.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190110/0837271b/attachment.asc>
