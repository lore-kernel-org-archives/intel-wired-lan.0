From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 30 Nov 2016 13:15:22 -0800
Subject: [Intel-wired-lan] [net PATCH 0/2] Don't use lco_csum to compute
	IPv4 checksum
In-Reply-To: <20161130.094746.724735454244491985.davem@davemloft.net>
References: <20161128153927.15466.99193.stgit@ahduyck-blue-test.jf.intel.com>
 <20161130.094746.724735454244491985.davem@davemloft.net>
Message-ID: <1480540522.2377.18.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-11-30 at 09:47 -0500, David Miller wrote:
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> Date: Mon, 28 Nov 2016 10:42:18 -0500
> 
> > When I implemented the GSO partial support in the Intel drivers I was
> using
> > lco_csum to compute the checksum that we needed to plug into the IPv4
> > checksum field in order to cancel out the data that was not a part of
> the
> > IPv4 header.? However this didn't take into account that the transport
> > offset might be pointing to the inner transport header.
> >?
> > Instead of using lco_csum I have just coded around it so that we can
> use
> > the outer IP header plus the IP header length to determine where we
> need to
> > start our checksum and then just call csum_partial ourselves.
> >?
> > This should fix the SIT issue reported on igb interfaces as well as
> simliar
> > issues that would pop up on other Intel NICs.
> 
> Jeff, are you going to send me a pull request with this stuff or would
> you be OK with my applying these directly to 'net'?

Go ahead and apply those to your net tree, I do not want to hold this up.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161130/a9607036/attachment.asc>
