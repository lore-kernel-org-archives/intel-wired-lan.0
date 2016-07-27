From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 26 Jul 2016 23:01:56 -0700
Subject: [Intel-wired-lan] [PATCH V0] i40e: Program device correctly as
 part of adding flow director entry
In-Reply-To: <1469598563-42383-1-git-send-email-kiran.patil@intel.com>
References: <1469598563-42383-1-git-send-email-kiran.patil@intel.com>
Message-ID: <1469599316.2851.50.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-07-26 at 22:49 -0700, Kiran Patil wrote:
> This patch fixes the problem where driver was not programming
> underlying device correctly when user specifies less than full tuple
> set as part of adding flow director entry (for flow-type tcp4/udp4)
> using ethtool.
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Change-Id: I90052508f8c172c0da5a4b78b949704b4a59ea78
> Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
> ---
> ?drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 116
> +++++++++++++++++++++++++
> ?1 file changed, 116 insertions(+)

Andrew, I know your tested-by is already on this, but I also know it was
not tested while in my dev-queue branch of my next-queue tree. ?Can you
please verify this patch in my tree? ?No need to send another tested-by,
just let me know if your tested-by still stands.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160726/514e49c4/attachment.asc>
