From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 08 Jan 2016 10:08:58 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: Make all unchanging ops
 structures const
In-Reply-To: <20160107181303.82798.52945.stgit@mdrustad-wks.jf.intel.com>
References: <20160107181303.82798.52945.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <1452276538.26830.2.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2016-01-07 at 10:13 -0800, Mark D Rustad wrote:
> The source for the ops structure contents are const, so make them
> so. Copy them in place with structure assignments instead of memcpys.
> Make the mbx_ops accessed by reference instead of making a copy of
> the source structure. Update copyright date on the touched files.
> 
> Reported-by: Julia Lawall <Julia.Lawall@lip6.fr>
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> ---
> Changes in V2:
> - Access mbx_ops by reference instead of copying the structure. Saves
> a
> ? little bloat.

Julia- Please reply to the mailing list when responding with and
feedback or ACK's so that they are properly captured. ?Replying
privately is generally frowned upon.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160108/679750b5/attachment.asc>
