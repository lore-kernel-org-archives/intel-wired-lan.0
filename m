From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 16 May 2016 12:56:56 -0700
Subject: [Intel-wired-lan] [next PATCH S37 10/15] i40e: Removing
 unnecessary code which caused supported link mode bug
In-Reply-To: <475EF86EA1AC844AA3BA8EE1F912AD6903CCA105@ORSMSX111.amr.corp.intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
 <1463419605-30746-11-git-send-email-bimmy.pujari@intel.com>
 <475EF86EA1AC844AA3BA8EE1F912AD6903CCA105@ORSMSX111.amr.corp.intel.com>
Message-ID: <1463428616.2609.2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2016-05-16 at 18:26 +0000, Dayanand, Avinash wrote:
> ACK, looks good..?

Do not top-post! ?Patchwork thought you were submitting a new patch,
instead of responding to a patch that was already in the queue.

> -----Original Message-----
> From: Pujari, Bimmy?
> Sent: Monday, May 16, 2016 10:27 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Dayanand, Avinash <avinash.dayanand@intel.com>
> Subject: [next PATCH S37 10/15] i40e: Removing unnecessary code which
> caused supported link mode bug
> 
> From: Avinash Dayanand <avinash.dayanand@intel.com>
> 
> Removing this code which wasn't allowing 100BaseT to show up in the
> supported link modes for 10GBaseT PHYs.
> 
> Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
> Change-ID: Iada2eafa7ef6b4bac9a2a1380ff533ae5de51e1d
> ---
> Testing Hints: Use 'ethtool ethx' check if 100BaseT is listed as one of
> the supported link modes.
> 
> ?drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 3 +--
> ?1 file changed, 1 insertion(+), 2 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160516/f72150d5/attachment.asc>
