From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 03 Dec 2015 04:13:46 -0800
Subject: [Intel-wired-lan] [PATCH] i40e: Fix i40e_print_features() VEB
	mode output
In-Reply-To: <1449045535.3716.10.camel@perches.com>
References: <1448475679-57194-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1448475679-57194-5-git-send-email-jeffrey.t.kirsher@intel.com>
 <5655FD72.70902@cogentembedded.com> <1448476535.3021.5.camel@intel.com>
 <1448480194.20113.48.camel@perches.com>
 <1449002936.1593.10.camel@perches.com> <1449041100.3224.17.camel@intel.com>
 <1449045535.3716.10.camel@perches.com>
Message-ID: <1449144826.3224.46.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2015-12-02 at 00:38 -0800, Joe Perches wrote:
> Commit 7fd89545f337 ("i40e: remove BUG_ON from feature string
> building")
> added defective output when I40E_FLAG_VEB_MODE_ENABLED was set in
> function i40e_print_features.
> 
> Fix it.
> 
> Miscellanea:
> 
> o Remove unnecessary string variable
> o Add space before not after fixed strings
> o Use kmalloc not kzalloc
> o Don't initialize i to 0, use result of first snprintf
> 
> Noticed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> ?drivers/net/ethernet/intel/i40e/i40e_main.c | 42 +++++++++++++----
> ------------
> ?1 file changed, 19 insertions(+), 23 deletions(-)

Your patch does not apply cleanly, it appears you used Dave's net-next
tree to generate your patch, versus my next-queue tree (dev-queue
branch) which has a number of i40e patches already applied.

As a one-time only reminder, I have gone ahead and applied your patch
by hand. ?I will send your updated patch out here in just a minute.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151203/a43bd7a2/attachment.asc>
