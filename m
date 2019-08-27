From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 27 Aug 2019 12:02:23 -0700
Subject: [Intel-wired-lan] [PATCH] net: intel: Cleanup e1000 - add space
 between }}
In-Reply-To: <877726fc009ee5ffde50e589d332db90c9695f06.camel@perches.com>
References: <20190823191421.3318-1-ffleming@gmail.com>
 <c2279a78904b581924894b712403299903eacbfc.camel@intel.com>
 <877726fc009ee5ffde50e589d332db90c9695f06.camel@perches.com>
Message-ID: <c40b4043424055fc4dae97771bb46c8ab15c6230.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2019-08-26 at 20:41 -0700, Joe Perches wrote:
> On Mon, 2019-08-26 at 01:03 -0700, Jeff Kirsher wrote:
> > On Fri, 2019-08-23 at 19:14 +0000, Forrest Fleming wrote:
> > > suggested by checkpatch
> > > 
> > > Signed-off-by: Forrest Fleming <ffleming@gmail.com>
> > > ---
> > >  .../net/ethernet/intel/e1000/e1000_param.c    | 28 +++++++++--
> > > --------
> > >  1 file changed, 14 insertions(+), 14 deletions(-)
> > 
> > While I do not see an issue with this change, I wonder how
> > important it is
> > to make such a change.  Especially since most of the hardware
> > supported by
> > this driver is not available for testing.  In addition, this is one
> > suggested change by checkpatch.pl that I personally do not agree
> > with.
> 
> I think checkpatch should allow consecutive }}.

Agreed, have you already submitted a formal patch Joe with the
suggested change below?  If so, I will ACK it.

> 
> Maybe:
> ---
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 287fe73688f0..ac5e0f06e1af 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -4687,7 +4687,7 @@ sub process {
>  
>  # closing brace should have a space following it when it has
> anything
>  # on the line
> -		if ($line =~ /}(?!(?:,|;|\)))\S/) {
> +		if ($line =~ /}(?!(?:,|;|\)|\}))\S/) {
>  			if (ERROR("SPACING",
>  				  "space required after that close
> brace '}'\n" . $herecurr) &&
>  			    $fix) {
> 
> 

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190827/cf798b22/attachment.asc>
