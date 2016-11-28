From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 29 Nov 2016 10:43:04 +1100
Subject: [Intel-wired-lan] [net PATCH 0/2] Don't use lco_csum to compute
	IPv4 checksum
In-Reply-To: <1480371962.2402.36.camel@intel.com>
References: <20161128153927.15466.99193.stgit@ahduyck-blue-test.jf.intel.com>
 <1480371962.2402.36.camel@intel.com>
Message-ID: <20161129104253.00ada847@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jeff,

On Mon, 28 Nov 2016 14:26:02 -0800 Jeff Kirsher <jeffrey.t.kirsher@intel.com> wrote:
>
> On Mon, 2016-11-28 at 10:42 -0500, Alexander Duyck wrote:
> > When I implemented the GSO partial support in the Intel drivers I was
> > using
> > lco_csum to compute the checksum that we needed to plug into the IPv4
> > checksum field in order to cancel out the data that was not a part of the
> > IPv4 header.? However this didn't take into account that the transport
> > offset might be pointing to the inner transport header.
> > 
> > Instead of using lco_csum I have just coded around it so that we can use
> > the outer IP header plus the IP header length to determine where we need
> > to
> > start our checksum and then just call csum_partial ourselves.
> > 
> > This should fix the SIT issue reported on igb interfaces as well as
> > simliar
> > issues that would pop up on other Intel NICs.
> > 
> > ---
> > 
> > Alexander Duyck (2):
> > ????? igb/igbvf: Don't use lco_csum to compute IPv4 checksum
> > ????? ixgbe/ixgbevf: Don't use lco_csum to compute IPv4 checksum  
> 
> Stephen, I have applied Alex's patches to my net-queue tree. ?Can you
> confirm they resolve the bug seen?

Its a bit tricky because the origin problem only happens on my
production server (ozlabs.org), but I will see if I can manage to just
remove and reload the driver ...  though, the server is running a 4.7.8
kernel and I am wondering how well these patches will apply?

-- 
Cheers,
Stephen Rothwell
