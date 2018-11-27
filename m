From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 27 Nov 2018 09:31:38 -0800
Subject: [Intel-wired-lan] [PATCH] i40e: fix kerneldoc for xsk methods
In-Reply-To: <8DB98857419E2C4496D37EA0B91B597076B0D9EA@IRSMSX103.ger.corp.intel.com>
References: <8DB98857419E2C4496D37EA0B91B597076B0D9EA@IRSMSX103.ger.corp.intel.com>
Message-ID: <95231638a51066b8ea826777fd196285c3b49d45.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2018-11-27 at 08:19 +0000, Sokolowski, Jan wrote:
> One method, xsk_umem_setup, had an incorrect kernel doc
> description, which has been corrected.
>  
> Also fixes small typos found in the comments.
>  
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> ---
> drivers/net/ethernet/intel/i40e/i40e_xsk.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)

Hmm, not sure why your patch is so corrupted.  Are you sending it as
plain text?

I have fixed it up and will resubmit it to IWl for you.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20181127/27d23df1/attachment-0001.asc>
