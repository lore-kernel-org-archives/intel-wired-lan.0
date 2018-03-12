From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 12 Mar 2018 09:56:30 -0700
Subject: [Intel-wired-lan] [PATCH 01/15] ice: Add basic driver framework
 for Intel(R) E800 Series
In-Reply-To: <20180309141639.69c4f354@cakuba.netronome.com>
References: <20180309172136.9073-1-anirudh.venkataramanan@intel.com>
 <20180309172136.9073-2-anirudh.venkataramanan@intel.com>
 <20180309141639.69c4f354@cakuba.netronome.com>
Message-ID: <1520873790.19785.4.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2018-03-09 at 14:16 -0800, Jakub Kicinski wrote:
> On Fri,  9 Mar 2018 09:21:22 -0800, Anirudh Venkataramanan wrote:
> > diff --git a/Documentation/networking/ice.txt
> > b/Documentation/networking/ice.txt
> > new file mode 100644
> > index 000000000000..6261c46378e1
> > --- /dev/null
> > +++ b/Documentation/networking/ice.txt
> 
> nit: ice.rst, maybe?

If that is the desired direction for kernel documentation, then we can
work on generating *.rst for all of our wired ethernet drivers.  For
now, we just have the simple text file.

Currently there are only 5 networking drivers that have a *.rst for
documentation, so it looks like an opportunity to convert all the
networking documentation to *.rst format, if that is desired. 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180312/14313cd8/attachment.asc>
