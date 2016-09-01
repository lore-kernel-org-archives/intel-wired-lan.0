From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 31 Aug 2016 20:17:42 -0700
Subject: [Intel-wired-lan] [PATCH v2] checkpatch.pl: seed camelcase from
 the provided kernel tree root
In-Reply-To: <1472697962.4176.77.camel@perches.com>
References: <20160829210047.25111-1-jacob.e.keller@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81F7A0C0@ORSMSX101.amr.corp.intel.com>
 <02874ECE860811409154E81DA85FBB5857B8D29D@ORSMSX115.amr.corp.intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81F7A333@ORSMSX101.amr.corp.intel.com>
 <1472697190.2453.14.camel@intel.com> <1472697962.4176.77.camel@perches.com>
Message-ID: <1472699862.2453.18.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-08-31 at 19:46 -0700, Joe Perches wrote:
> On Wed, 2016-08-31 at 19:33 -0700, Jeff Kirsher wrote:
> > 
> > On Thu, 2016-09-01 at 01:04 +0000, Brown, Aaron F wrote:
> > > 
> > > From: Keller, Jacob E
> 
> Hi all.
> 
> > 
> > > 
> > > > 
> > > > > 
> > > > > ---------------------------------------------------------------
> > > > > ------
> > > > > The first is clearly a false warning, thinks checkpatch is the
> > > > > tool
> > > > > that found the error rather than the tool being fixed.? ;)?? The
> > > > > second is just
> > > > > a long line in the perl code, which I don't really consider a
> > > > > blocking issue so...
> > > > Ya I saw those. I saw many lines over 80 characters in the file so
> > > > I
> > > > just assumed we don't bother checking the tool with itself.
> > > Well, it showed up in as a patch so I ran it through...? But yeah, it
> > > does not make sense to enforce rules intended for the kernel against
> > > something else.? Especially as the precedent for line length is
> > > clearly
> > > already in the file
> > Although it technically is a part of the kernel source since it is in
> > scripts. ?So the question is, should kernel scripts follow the coding
> > standards? ?If so, then yes it should follow its own rules for kernel
> > source.
> > 
> > Personally I do not think it should be an issue for the contents of
> > /scripts in the kernel source, but that would be an interesting
> > question to
> > pose to Joe Perches and the other checkpatch.pl warlords.
> 
> Warlord? ?Damn. ?Where are my spoils of war?

I thought you got $0.02 for every checkpatch.pl warning and $0.05 for every
error found? :-)

> Perl is already basically unintelligible.
> 80 column perl would be a whole lot worse.

Agreed.

> Anyway, I don't look at scripts with checkpatch.
> 
> I think it's really only useful for .[ch] files.

So should a modification be made to anything in scripts/* for when
checkpatch.pl is run? ?I know that there are *special* rules for
drivers/net/*, so it should be easy to apply whatever checks are pertinent
for scripts/*?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160831/a61db057/attachment.asc>
