From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 25 Jan 2016 16:01:43 -0800
Subject: [Intel-wired-lan] [PATCH 1/3] i40e: fix build warning
In-Reply-To: <1453702251-464-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1453702251-464-1-git-send-email-sudipm.mukherjee@gmail.com>
Message-ID: <1453766503.2932.13.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2016-01-25 at 11:40 +0530, Sudip Mukherjee wrote:
> While building we are getting warning about:
> i40e_main.c:8604:13: warning: 'i40e_add_geneve_port' defined but not
> used
> and
> i40e_main.c:8651:13: warning: 'i40e_del_geneve_port' defined but not
> used
> 
> The contents of these functions are defined under CONFIG_GENEVE, so
> if
> CONFIG_GENEVE is not defined then we are having unused empty
> functions.
> Lets have these functions under CONFIG_GENEVE as the callback is
> already
> defined under CONFIG_GENEVE there is no chance of any failure.
> 
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> ---
> ?drivers/net/ethernet/intel/i40e/i40e_main.c | 6 ++----
> ?1 file changed, 2 insertions(+), 4 deletions(-)

This is not a complete fix for the issue and Eric Dumazet has already
submitted a fix for the issue, which I have just sent to David Miller
in a pull-request.

So I have dropped this patch, in favor of Eric's solution.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160125/aee32eea/attachment.asc>
