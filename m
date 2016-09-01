From: Joe Perches <joe@perches.com>
Date: Wed, 31 Aug 2016 20:26:51 -0700
Subject: [Intel-wired-lan] [PATCH v2] checkpatch.pl: seed camelcase from
 the provided kernel tree root
In-Reply-To: <1472699862.2453.18.camel@intel.com>
References: <20160829210047.25111-1-jacob.e.keller@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81F7A0C0@ORSMSX101.amr.corp.intel.com>
 <02874ECE860811409154E81DA85FBB5857B8D29D@ORSMSX115.amr.corp.intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81F7A333@ORSMSX101.amr.corp.intel.com>
 <1472697190.2453.14.camel@intel.com> <1472697962.4176.77.camel@perches.com>
 <1472699862.2453.18.camel@intel.com>
Message-ID: <1472700411.4176.83.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-08-31 at 20:17 -0700, Jeff Kirsher wrote:

> I thought you got $0.02 for every checkpatch.pl warning and $0.05 for every
> error found? :-)

Well, it's nice to know some credits are accruing in
some virtual bank. ?Unfortunate for me that it's like
the Hotel California Bank though.

> > I don't look at scripts with checkpatch.
> > I think it's really only useful for .[ch] files.
> So should a modification be made to anything in scripts/* for when
> checkpatch.pl is run? ?I know that there are *special* rules for
> drivers/net/*, so it should be easy to apply whatever checks are pertinent
> for scripts/*?

I think scripts should rely a little on the skill
and intelligence of the user.

I have a hammer so let's go fishing, etc...

cheers, ?Joe
