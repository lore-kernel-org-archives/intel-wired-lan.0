From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 26 Aug 2019 01:03:33 -0700
Subject: [Intel-wired-lan] [PATCH] net: intel: Cleanup e1000 - add space
 between }}
In-Reply-To: <20190823191421.3318-1-ffleming@gmail.com>
References: <20190823191421.3318-1-ffleming@gmail.com>
Message-ID: <c2279a78904b581924894b712403299903eacbfc.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2019-08-23 at 19:14 +0000, Forrest Fleming wrote:
> suggested by checkpatch
> 
> Signed-off-by: Forrest Fleming <ffleming@gmail.com>
> ---
>  .../net/ethernet/intel/e1000/e1000_param.c    | 28 +++++++++----------
>  1 file changed, 14 insertions(+), 14 deletions(-)

While I do not see an issue with this change, I wonder how important it is
to make such a change.  Especially since most of the hardware supported by
this driver is not available for testing.  In addition, this is one
suggested change by checkpatch.pl that I personally do not agree with.

This is not a hard NAK, but you have to explain how this change makes the
code more readable before I consider it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190826/db4fc78d/attachment.asc>
