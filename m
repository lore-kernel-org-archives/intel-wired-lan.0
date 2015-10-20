From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 20 Oct 2015 16:06:13 -0700
Subject: [Intel-wired-lan] [PATCH] fm10k:Fix error handling in the
	function fm10k_setup_tc
In-Reply-To: <1445375114-13378-1-git-send-email-xerofoify@gmail.com>
References: <1445375114-13378-1-git-send-email-xerofoify@gmail.com>
Message-ID: <1445382373.2937.10.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-10-20 at 17:05 -0400, Nicholas Krause wrote:
> This fixes error handling in the function fm10k_setup_tc to properly
> check if the call to the function fm10k_open has failed by returning
> a error and if so return immediately to the caller of the function
> fm10k_setup_tc to properly signal this non recoverable failure.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Is this a version 2 of your original patch you sent out with the same
title and patch description?  It is difficult to understand the reason
for the change without a sufficient changelog (i.e. why the new version
of the patch).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151020/088641b5/attachment.asc>
