From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 1 Sep 2016 01:04:02 +0000
Subject: [Intel-wired-lan] [PATCH v2] checkpatch.pl: seed camelcase from
 the	provided kernel tree root
In-Reply-To: <02874ECE860811409154E81DA85FBB5857B8D29D@ORSMSX115.amr.corp.intel.com>
References: <20160829210047.25111-1-jacob.e.keller@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B81F7A0C0@ORSMSX101.amr.corp.intel.com>
 <02874ECE860811409154E81DA85FBB5857B8D29D@ORSMSX115.amr.corp.intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81F7A333@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Keller, Jacob E
> Sent: Wednesday, August 31, 2016 3:37 PM
> To: Brown, Aaron F <aaron.f.brown@intel.com>; Intel Wired LAN <intel-
> wired-lan at lists.osuosl.org>
> Subject: RE: [Intel-wired-lan] [PATCH v2] checkpatch.pl: seed camelcase from
> the provided kernel tree root
> 
<snip>
> > total: 0 errors, 2 warnings, 22 lines checked
> > ---------------------------------------------------------------------
> > The first is clearly a false warning, thinks checkpatch is the tool that found
> > the error rather than the tool being fixed.  ;)   The second is just a long line
> in
> > the perl code, which I don't really consider a blocking issue so...
> >
> 
> Ya I saw those. I saw many lines over 80 characters in the file so I just
> assumed we don't bother checking the tool with itself.

Well, it showed up in as a patch so I ran it through...  But yeah, it does not make sense to enforce rules intended for the kernel against something else.  Especially as the precedent for line length is clearly already in the file ;)
