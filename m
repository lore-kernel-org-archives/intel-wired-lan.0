From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 14 Oct 2015 18:23:03 -0700
Subject: [Intel-wired-lan] [PATCH RESEND 1/2] ixgb:Remove reducant error
 path after call to ixgb_sw_init in the function ixgb_probe
In-Reply-To: <1444863479-31570-1-git-send-email-xerofoify@gmail.com>
References: <1444863479-31570-1-git-send-email-xerofoify@gmail.com>
Message-ID: <1444872183.2928.6.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2015-10-14 at 18:57 -0400, Nicholas Krause wrote:
> This removes the reducant error path and now no longer used goto
> label  err_sw_init after the call to ixgb_probe in the function
> ixgb_sw_init after calling this function due to it always returning
> zero as it is guarantee to run successfully without any issues.
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  drivers/net/ethernet/intel/ixgb/ixgb_main.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

This driver (ixgb), as well as e100 and e1000 are in maintenance mode
which means bug fixes ONLY!

Is this patch necessary?  Answer: No
Is this a bug fix?  Answer: No
Should you have sent this patch?  See answers to previous questions.

Please ask these questions to yourself when putting together a patch
against these drivers (listed above).

With that said, dropping this series.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151014/61473924/attachment.asc>
