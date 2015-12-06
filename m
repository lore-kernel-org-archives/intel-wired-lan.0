From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Sat, 05 Dec 2015 23:35:07 -0800
Subject: [Intel-wired-lan] [PATCH RESEND] fm10k:Fix error handling in
 the function fm10k_resume
In-Reply-To: <1449369415-22303-1-git-send-email-xerofoify@gmail.com>
References: <1449369415-22303-1-git-send-email-xerofoify@gmail.com>
Message-ID: <1449387307.3198.22.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, 2015-12-05 at 21:36 -0500, Nicholas Krause wrote:
> This fixes error handling to proper check if the call to the function
> fm10k_mbx_request_irq has failed by returning a error code and if
> so return immediately to the caller of fm10k_resume to properly
> signal a failure has occurred when accepting to resume this network
> 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> Tested-by: Krishneil SIngh <krishneil.k.singh@intel.com
> ---
> ?drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 4 +++-
> ?1 file changed, 3 insertions(+), 1 deletion(-)

Don't bother, David Miller has spoken and will not accept any patches
from you. ?So even though this was not properly sent to intel-wired-
lan at lists.osuosl.org, which all kernel patches need to be sent to, I am
dropping this patch since David Miller will not accept ANY patches from
you.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151205/c4fbf0f6/attachment.asc>
