From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 04 Mar 2020 11:16:53 -0800
Subject: [Intel-wired-lan] [PATCH net 0/1] e1000e: Stop tx/rx setup
 spinning for upwards of 300us.
In-Reply-To: <20200304111008.2c85f386@kicinski-fedora-PC1C0HJN>
References: <9e23756531794a5e8b3d7aa6e0a6e8b6@AcuMS.aculab.com>
 <32fd09495d86bb2800def5b19e782a6a91a74ed9.camel@intel.com>
 <20200304111008.2c85f386@kicinski-fedora-PC1C0HJN>
Message-ID: <6ae80c13890cb71f6e079393173b08c5b4bd9917.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2020-03-04 at 11:10 -0800, Jakub Kicinski wrote:
> On Wed, 04 Mar 2020 10:02:08 -0800 Jeff Kirsher wrote:
> > Adding the intel-wired-lan at lists.osuosl.org mailing list, so that
> > the
> > developers you want feedback from will actually see your
> > patches/questions/comments.
> 
> Is that list still moderated? I was going to CC it yesterday but 
> I don't want to subject people who respond to moderation messages..

Yes, this is still moderated, helps keep the crap email out of peoples
inbox.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200304/999e0a46/attachment-0001.asc>
